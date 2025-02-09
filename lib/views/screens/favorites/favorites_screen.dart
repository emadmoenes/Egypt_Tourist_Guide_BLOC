import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/core/services/firebase_service.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:egypt_tourist_guide/views/widgets/place_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {


  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale.toString() == 'en';
    context.read<PlacesBloc>().add(GetFavouritePlaces(isEnglish));
    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        if (state is FavouritePlacesSuccess){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (state.places.isEmpty)
                  ? Center(
                child: Text('no_favorites'.tr()),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: state.places.length,
                  itemBuilder: (context, index) {
                    final place = state.places[index];
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
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
