import 'package:google_maps_flutter/google_maps_flutter.dart';
class PlacesModel {
  final int id;
  final String governorateId;
  final String name;
  final String description;
  final String image;
  bool isFav;
  final LatLng location;

  PlacesModel({
    required this.id,
    required this.governorateId,
    required this.name,
    required this.description,
    required this.image,
    required this.isFav,
    required this.location,
  });
}
