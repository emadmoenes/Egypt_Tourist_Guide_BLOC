class PlacesModel {
  final int id;
  final String? governorateId;
  final String name;
  final String description;
  final String image;
  bool isFav;

  PlacesModel({
    required this.id,
    required this.governorateId,
    required this.name,
    required this.description,
    required this.image,
    required this.isFav,
  });

  factory PlacesModel.fromMap(Map<String, dynamic> map) {
    return PlacesModel(
      id: map['id'] as int,
      governorateId: map['governorateID'] as String?,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      isFav: map['isFav'] as bool,
    );
  }
}