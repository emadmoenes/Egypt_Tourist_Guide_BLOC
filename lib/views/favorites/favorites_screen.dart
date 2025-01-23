import 'package:egypt_tourist_guide/data.dart';
import 'package:flutter/material.dart';
import 'package:egypt_tourist_guide/views/widgets/place_card.dart';
import 'package:easy_localization/easy_localization.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritePlaces =  context.locale.toString() == 'ar' ?
        ARABICPLACES.where((place) => place.isFav).toList():
        PLACES.where((place) => place.isFav).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (favoritePlaces.isEmpty)
              Center(
                child: Text('no_favorites'.tr()),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: favoritePlaces.length,
                  itemBuilder: (context, index) {
                    final place = favoritePlaces[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlaceCard(
                        place: place,
                        isWide: true,
                        onFavoriteToggled: () {
                          setState(() {});
                        },
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
