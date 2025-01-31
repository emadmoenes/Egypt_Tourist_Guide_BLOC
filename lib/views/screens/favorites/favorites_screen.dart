import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:flutter/material.dart';
import 'package:egypt_tourist_guide/views/widgets/place_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var favoritePlaces = context.locale.toString() == 'ar'
        ? ARABICPLACES.where((place) => place.isFav).toList()
        : PLACES.where((place) => place.isFav).toList();

    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        if (state is FavoriteToggledState) {
          favoritePlaces = state.places.where((place) => place.isFav).toList();
        }

        return Column(
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
        );
      },
    );
  }
}
