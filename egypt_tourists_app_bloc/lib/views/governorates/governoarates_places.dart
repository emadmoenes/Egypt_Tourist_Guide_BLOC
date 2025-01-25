import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourists_app_bloc/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourists_app_bloc/core/app_colors.dart';
import 'package:egypt_tourists_app_bloc/models/governorate_model.dart';
import 'package:egypt_tourists_app_bloc/models/place_model.dart';
import 'package:egypt_tourists_app_bloc/views/home/widgets/home_section_title.dart';
import 'package:egypt_tourists_app_bloc/views/home/widgets/recommended_places_grid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GovernoratesPlaces extends StatelessWidget {
  final GovernorateModel governorate;
  final List<PlacesModel> places;

  const GovernoratesPlaces({
    super.key,
    required this.governorate,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${governorate.name} '),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Governorate image, name, and description
          // With hero animation
          Hero(
            tag: "hero-${governorate.id}",
            child: GovernorateContainer(governorate: governorate),
          ),
          HomeSectionTitle(text: "places".tr()),
          BlocBuilder<PlacesBloc, PlacesState>(
            builder: (context, state) {
              return RecommendedPlacesGrid(
                recommendedPlaces: places,
                isWide: true,
              );
            },
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////
/*----------- Governorate Container ------------*/
class GovernorateContainer extends StatelessWidget {
  const GovernorateContainer({
    super.key,
    required this.governorate,
  });

  final GovernorateModel governorate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.3,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(governorate.image),
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    governorate.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Text(
              governorate.description,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
