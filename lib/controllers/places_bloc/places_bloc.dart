import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  int currentPageIndex = 0;

  PlacesBloc() : super(PlacesInitial()) {
    //-- Handle load places event --//
    on<LoadPlacesEvent>((event, emit) async {
      emit(PlacesLoading());
      // make delay to show loading in home page design
      await Future.delayed(Duration(seconds: 2));
      emit(PlacesLoaded(places: PLACES));
    });
    //-- Handle load more places event --//
    on<LoadMorePlacesEvent>((event, emit) async {
      emit(PlacesLoading());
      // make delay to show loading in home page design
      await Future.delayed(Duration(seconds: 2));
      emit(PlacesLoaded(places: PLACES));
    });
    //-- Handle Toggle Favourite event --//
    on<ToggleFavouriteEvent>(
          (event, emit) {
        PlacesModel place = event.place;
        bool isArabic = event.isArabic;
        final index = PLACES.indexWhere((p) => p.id == place.id);
        if (isArabic) {
          ARABICPLACES[index].isFav = !ARABICPLACES[index].isFav;
          emit(PlacesLoaded(places: ARABICPLACES));
        }
        if (index != -1) {
          PLACES[index].isFav = !PLACES[index].isFav;
          emit(PlacesLoaded(places: PLACES));
        }
        if (!PLACES.contains(place)) {
          emit(PlacesError());
        }
        emit(FavoriteToggledState(place));
      },
    );
    //-- Handle bottom navigation event --//
    on<ChangeBottomNavigationIndexEvent>((
        ChangeBottomNavigationIndexEvent event, emit) {
      currentPageIndex = event.index;
      emit(BottomNavigationChangedState(currentPageIndex));
    });
  }
}
