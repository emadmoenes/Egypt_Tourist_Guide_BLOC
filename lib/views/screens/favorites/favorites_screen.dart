import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:egypt_tourist_guide/views/widgets/place_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isEnglish = context.locale.toString() == 'en';
    // context.read<PlacesBloc>().add(GetFavouritePlaces(isEnglish));
    double width = MediaQuery.sizeOf(context).width;
    List<PlacesModel> places = context.read<PlacesBloc>().favPlacesP;
    return BlocConsumer<PlacesBloc, PlacesState>(
      listener: (context, state) {
        if (state is FavoriteToggledState) {
          places = state.places;
        } else if (state is FavouritePlacesSuccess) {
          places = state.places;
        }
      },
      builder: (context, state) {
        if (state is FavouritePlacesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PlacesError) {
          return Center(
            child: Text(state.message),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (places.isEmpty)
                ? Center(
                    child: Text('no_favorites'.tr()),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
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
