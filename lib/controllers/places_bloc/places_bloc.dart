import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';

import '../../core/services/firebase_service.dart';

part 'places_event.dart';

part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  int currentPageIndex = 0;

  PlacesBloc() : super(PlacesInitial()) {
    //-- Handle load places event --//
    on<LoadPlacesEvent>(_loadPlaces);
    //-- Handle load more places event --//
    on<LoadMorePlacesEvent>(_loadMorePlaces);
    //-- Handle Toggle Favourite event --//
    on<ToggleFavouriteEvent>(_toggleFavourite);
    //-- Handle bottom navigation event --//
    on<ChangeBottomNavigationIndexEvent>(_changeBottomNavigationIndex);
    on<GetFavouritePlaces>(_getFavouritePlaces);
  }

  // handle load places event
  Future<void> _loadPlaces(
      LoadPlacesEvent event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    // make delay to show loading in home page design
    await Future.delayed(Duration(seconds: 2));
    emit(PlacesLoaded(places: PLACES));
  }

  // Handle load more places event
  Future<void> _loadMorePlaces(
      LoadMorePlacesEvent event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    // make delay to show loading in home page design
    await Future.delayed(Duration(seconds: 2));
    emit(PlacesLoaded(places: PLACES));
  }

  // handle Toggle Favourite event
  Future<void> _toggleFavourite(
      ToggleFavouriteEvent event, Emitter<PlacesState> emit) async {
    PlacesModel place = event.place;
    bool isArabic = event.isArabic;
    List<PlacesModel> places = [];
    final index = PLACES.indexWhere((p) => p.id == place.id);
    if (isArabic) {
      ARABICPLACES[index].isFav = !ARABICPLACES[index].isFav;
      places = ARABICPLACES;
    }
    if (index != -1) {
      PLACES[index].isFav = !PLACES[index].isFav;
      places = PLACES;
    }
    if (!PLACES.contains(place)) {
      emit(PlacesError());
    }
    emit(FavoriteToggledState(places: places, place: place));
  }

  // handle bottom navigation event
  Future<void> _changeBottomNavigationIndex(
      ChangeBottomNavigationIndexEvent event, Emitter<PlacesState> emit) async {
    currentPageIndex = event.index;
    emit(BottomNavigationChangedState(currentPageIndex));
  }

  // handle get favourite places event
  Future<void> _getFavouritePlaces(
      GetFavouritePlaces event, Emitter<PlacesState> emit) async {
    emit(FavouritePlacesLoading());
    List<int> placesId = await FirebaseService.getUserFavouritePlacesId(uid: FirebaseAuth.instance.currentUser!.uid);
    List<PlacesModel> places = [];
    for(int id in placesId){
      places.add(await FirebaseService.getPlaceById(id: id));
    }
    emit(FavouritePlacesSuccess(places: places));
  }
}
