import 'package:egypt_tourist_guide/views/home/widgets/popular_places_section.dart';
import 'package:egypt_tourist_guide/views/home/widgets/suggested_places_section.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'home_section_title.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeSectionTitle(text: 'popular-places'.tr()),
          PopularPlacesSection(),
          HomeSectionTitle(text: 'suggested_places'.tr()),
          SuggestedPlacesSection(),
        ],
      ),
    );
  }
}
