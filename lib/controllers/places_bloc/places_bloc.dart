import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
    try {
      PlacesModel place = event.place;
      User? user = FirebaseService.authInstance.currentUser;

      if (user == null) {
        emit(PlacesError(message: "no_user_found".tr()));
        return;
      }

      String uid = user.uid;

      // Get favourite places of that user
      final snapshot = await FirebaseService.users.where('uid', isEqualTo: uid).get();
      if (snapshot.docs.isEmpty) {
        emit(PlacesError(message: "no_user_found".tr()));
        return;
      }

      DocumentReference userDoc = snapshot.docs.first.reference;
      List<dynamic> favPlaces = snapshot.docs.first['favPlaces'] ?? [];

      // check if that place is favourite or not
      if (favPlaces.contains(place.id)) {
        favPlaces.remove(place.id);
      } else {
        favPlaces.add(place.id);
      }

      // update current favPlaces on firestore
      await userDoc.update({'favPlaces': favPlaces});

      // Getting the favourite places
      emit(FavouritePlacesLoading());
      List<int> placesId = await FirebaseService.getUserFavouritePlacesId(uid: FirebaseAuth.instance.currentUser!.uid, isEnglish: event.isEnglish);
      List<PlacesModel> places = [];
      for(int id in placesId){
        places.add(await FirebaseService.getPlaceById(id: id, isEnglish: event.isEnglish));
      }
      //Making the places isFav true for all places
      for (var place in places) {place.isFav=true;}
      emit(FavouritePlacesSuccess(places: places));

      emit(FavoriteToggledState(places: places, place: place));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
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
    List<int> placesId = await FirebaseService.getUserFavouritePlacesId(uid: FirebaseAuth.instance.currentUser!.uid, isEnglish: event.isEnglish);
    List<PlacesModel> places = [];
    for(int id in placesId){
      places.add(await FirebaseService.getPlaceById(id: id, isEnglish: event.isEnglish));
    }
    //Making the places isFav true for all places
    for (var place in places) {place.isFav=true;}
    emit(FavouritePlacesSuccess(places: places));
  }
}
