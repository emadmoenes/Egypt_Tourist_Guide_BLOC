import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/core/app_routes.dart';
import 'package:egypt_tourist_guide/models/governorate_model.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:egypt_tourist_guide/views/governorates/widgets/governorate_card.dart';
import 'package:flutter/material.dart';
import '../../data.dart';

class GovernoratesScreen extends StatelessWidget {
  const GovernoratesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the list of governorates based on the current locale
    final List<GovernorateModel> governorateList =
    context.locale.toString() == 'ar' ? ARABICGOVERNORATES : GOVERNERATES;

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    //--- Get governorate data ---//
    List<PlacesModel> getGovernorateData(String governorateId) {
      return context.locale.toString() == 'ar'
          ? ARABICPLACES.where((place) => place.governorateId == governorateId).toList()
          : PLACES.where((place) => place.governorateId == governorateId).toList();
    }

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var governorate = governorateList[index];
          return GovernorateCard(
            governorate: governorate,
            width: width,
            height: height,
            onTap: () {
              // Go to governorate places
              List<PlacesModel> listOfPlaces = getGovernorateData(governorate.id);

              // Navigate to GovernoratesPlaces with arguments
              Navigator.pushNamed(
                context,
                AppRoutes.placesRoute,
                arguments: {
                  // Pass the governorate object
                  'governorate': governorate,
                  // Pass the list of places
                  'places': listOfPlaces,
                },
              );
            },
          );
        },
        separatorBuilder: (context, counter) {
          return const SizedBox(
            height: 20,
          );
        },
        itemCount: governorateList.length,
      ),
    );
  }
}