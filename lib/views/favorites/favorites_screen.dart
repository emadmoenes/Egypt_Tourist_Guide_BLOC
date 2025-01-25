import 'package:egypt_tourist_guide/data.dart';
import 'package:flutter/material.dart';
import 'package:egypt_tourist_guide/views/widgets/place_card.dart';
import 'package:easy_localization/easy_localization.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritePlaces = context.locale.toString() == 'ar'
        ? ARABICPLACES.where((place) => place.isFav).toList()
        : PLACES.where((place) => place.isFav).toList();

    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (favoritePlaces.isEmpty)
                ? Center(
                    child: Text('no_favorites'.tr()),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: favoritePlaces.length,
                      itemBuilder: (context, index) {
                        final place = favoritePlaces[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                            vertical: width * 0.02,
                          ),
                          child: PlaceCard(
                            place: place,
                            isWide: true,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
