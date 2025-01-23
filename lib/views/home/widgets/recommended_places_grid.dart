import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:egypt_tourist_guide/views/widgets/place_card.dart';
import 'package:flutter/material.dart';

class RecommendedPlacesGrid extends StatelessWidget {
  final List<PlacesModel> recommendedPlaces;

  const RecommendedPlacesGrid(
      {super.key, required this.recommendedPlaces, this.isWide = false});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      shrinkWrap: true,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: width * 0.03, //0.04
          mainAxisSpacing: width * 0.04,
      ),
      itemBuilder: (context, counter) => PlaceCard(
        place: recommendedPlaces[counter],
        isWide: isWide,
      ),
      itemCount: recommendedPlaces.length,
    );
  }
}
