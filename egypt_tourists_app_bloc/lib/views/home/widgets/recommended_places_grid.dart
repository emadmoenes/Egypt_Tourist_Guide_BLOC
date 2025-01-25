import 'package:egypt_tourists_app_bloc/models/place_model.dart';
import 'package:egypt_tourists_app_bloc/views/widgets/place_card.dart';
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
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.03,
        mainAxisSpacing: width * 0.03,
      ),
      itemBuilder: (context, index) => PlaceCard(
        place: recommendedPlaces[index],
        isWide: isWide,
      ),
      itemCount: recommendedPlaces.length,
    );
  }
}
