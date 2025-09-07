import 'package:favorite_place_app/providers/places_provider.dart';
import 'package:favorite_place_app/screens/new_place_add.dart';
import 'package:favorite_place_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture=ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Places')),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : PlacesList(places: userPlaces),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => AddPlaceScreen()));
        },
        shape: RoundedRectangleBorder(),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: Icon(Icons.add),
      ),
    );
  }
}
