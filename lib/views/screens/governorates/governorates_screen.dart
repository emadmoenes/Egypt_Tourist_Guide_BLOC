import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/core/app_routes.dart';
import 'package:egypt_tourist_guide/core/services/firebase_service.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:egypt_tourist_guide/models/governorate_model.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:egypt_tourist_guide/views/screens/governorates/widgets/governorate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../controllers/places_bloc/places_bloc.dart';


class GovernoratesScreen extends StatefulWidget {
  const GovernoratesScreen({super.key});

  @override
  State<GovernoratesScreen> createState() => _GovernoratesScreenState();
}

class _GovernoratesScreenState extends State<GovernoratesScreen> {
  List<GovernorateModel> governorateList = [];
  List<GovernorateModel> arabicGovernorateList = [];

  @override
  void initState() {
    super.initState();
    getGovernoratesFromFirebase();
  }

  //--- Get governorates from firebase ---//
  Future<void> getGovernoratesFromFirebase() async {

    var arabicGovernorateListFirebase =
        await FirebaseService.getArabicGovernorates();
    var governorateListFirebase = await FirebaseService.getGovernorates();
    setState(() {
      governorateList = governorateListFirebase;
      arabicGovernorateList = arabicGovernorateListFirebase;
    });
  }

  //--- Get governorates static data ---//
  List<GovernorateModel> _getGovernoratesStaticData() {
    final List<GovernorateModel> staticGovernoratesData = [];

    if (context.locale.toString() == 'ar') {
      staticGovernoratesData.addAll(ARABICGOVERNORATES);
    } else {
      staticGovernoratesData.addAll(GOVERNERATES);
    }
    return staticGovernoratesData;
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    //--- Get governorate's places data ---//
    List<PlacesModel> getGovernorateData(String governorateId) {
      final placesBloc = context.read<PlacesBloc>();

      return placesBloc.placesV
          .where((place) => place.governorateId == governorateId)
          .toList();
    }

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Skeletonizer(
        enabled: governorateList.isEmpty || arabicGovernorateList.isEmpty,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var governorate =
                arabicGovernorateList.isEmpty || governorateList.isEmpty
                    ? _getGovernoratesStaticData()[index]
                    : context.locale.toString() == 'ar'
                        ? arabicGovernorateList[index]
                        : governorateList[index];
            return GovernorateCard(
              governorate: governorate,
              width: width,
              height: height,
              onTap: () {
                // Go to governorate places
                List<PlacesModel> listOfPlaces =
                    getGovernorateData(governorate.id);

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
          itemCount: arabicGovernorateList.isEmpty || governorateList.isEmpty
              ? _getGovernoratesStaticData().length
              : context.locale.toString() == 'ar'
                  ? arabicGovernorateList.length
                  : governorateList.length,
        ),
      ),
    );
  }
}
