import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid=Uuid();

class Place {
  final String name;
  final File image;
  final String id;
  Place({required this.name, required this.image,id}):id=id??uuid.v4();
}
