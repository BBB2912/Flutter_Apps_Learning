import 'dart:io';

import 'package:favorite_place_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:logger/logger.dart';

var logger = Logger();

Future<Database> _getDatabse() async {
  final dbPath = await sql.getDatabasesPath();
  logger.i(dbPath);
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title Text, image Text)',
      );
    },
    version: 1,
  );
  logger.i(db);

  return db;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabse();
    final data = await db.query('user_places');
    logger.i(data);
    final places = data
        .map(
          (place) => Place(
            id: place['id'],
            name: place['title'] as String,
            image: File(place['image'] as String),
          ),
        )
        .toList();

    logger.i(places);

    state = places;
  }

  void addPlace(String title, File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    logger.i(appDir);
    final fileName = path.basename(image.path);
    logger.i(fileName);
    final copiedImage = await image.copy('${appDir.path}/$fileName');
    logger.i(copiedImage);
    final newPlace = Place(name: title, image: copiedImage);
    final db = await _getDatabse();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.name,
      'image': newPlace.image.path,
    });
    state = [...state, newPlace];
  }

  void removePlace(Place place) async {
    final db = await _getDatabse();
    await db.delete('user_places', where: 'id=?', whereArgs: [place.id]);
    state = state.where((p) => p.name != place.name).toList();
  }
}

final placesProvider = StateNotifierProvider((ref) {
  return PlacesNotifier();
});
