import 'dart:developer';

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

  List<PlacesModel> placesV = [];

  // handle load places event
  Future<void> _loadPlaces(
      LoadPlacesEvent event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    // Get places from firebase
    placesV = [];
    if (event.isEnglish) {
      List<PlacesModel> placesE = await FirebaseService.getPlaces();
      placesV = placesE;
    } else {
      List<PlacesModel> placesA = await FirebaseService.getArabicPlaces();

      placesV = placesA;
    }
    log('places success with length: ${placesV.length}');
    emit(PlacesLoaded(places: placesV));
  }

  // Handle load more places event
  Future<void> _loadMorePlaces(
      LoadMorePlacesEvent event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    emit(PlacesLoaded(places: PLACES));
  }

  // handle Toggle Favourite event
  Future<void> _toggleFavourite(
      ToggleFavouriteEvent event, Emitter<PlacesState> emit) async {
    try {
      PlacesModel placeE = event.place;
      User? user = FirebaseService.authInstance.currentUser;

      if (user == null) {
        emit(PlacesError(message: "no_user_found".tr()));
        return;
      }

      String uid = user.uid;

      // Get favourite places of that user
      final snapshot =
          await FirebaseService.users.where('uid', isEqualTo: uid).get();
      if (snapshot.docs.isEmpty) {
        emit(PlacesError(message: "no_user_found".tr()));
        return;
      }

      DocumentReference userDoc = snapshot.docs.first.reference;
      List<dynamic> favPlaces = snapshot.docs.first['favPlaces'] ?? [];

      // check if that place is favourite or not
      if (favPlaces.contains(placeE.id)) {
        favPlaces.remove(placeE.id);
      } else {
        favPlaces.add(placeE.id);
      }

      // update current favPlaces on firestore
      await userDoc.update({'favPlaces': favPlaces});

      // Getting the favourite places
      favPlacesP = [];
      List<int> placesId = await FirebaseService.getUserFavouritePlacesId(
          uid: FirebaseAuth.instance.currentUser!.uid,
          isEnglish: event.isEnglish);
      //List<PlacesModel> places = [];
      for (int id in placesId) {
        favPlacesP.add(await FirebaseService.getPlaceById(
            id: id, isEnglish: event.isEnglish));
      }
      //Making the places isFav true for all places
      for (var place in favPlacesP) {
        place.isFav = true;
      }
      emit(FavouritePlacesSuccess(places: favPlacesP));

      emit(FavoriteToggledState(places: favPlacesP, place: placeE));
      // placesV
      //     .where(
      //       (place) => place.id == placeE.id
      //           ? place.isFav = placeE.isFav
      //           : place.isFav,
      //     )
      //     .toList();
      // emit(PlacesLoaded(places: placesV));
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

  List<PlacesModel> favPlacesP = [];

  // handle get favourite places event
  Future<void> _getFavouritePlaces(
      GetFavouritePlaces event, Emitter<PlacesState> emit) async {
    emit(FavouritePlacesLoading());
    favPlacesP = [];
    try {
      List<int> placesId = await FirebaseService.getUserFavouritePlacesId(
          uid: FirebaseAuth.instance.currentUser!.uid,
          isEnglish: event.isEnglish);
      for (int id in placesId) {
        favPlacesP.add(await FirebaseService.getPlaceById(
            id: id, isEnglish: event.isEnglish));
      }
      //Making the places isFav true for all places
      for (var place in favPlacesP) {
        place.isFav = true;
      }
      emit(FavouritePlacesSuccess(places: favPlacesP));
      log('favourite places success with length: ${favPlacesP.length}');
      // placesV
      //     .where(
      //       (place) => favPlacesP.contains(place) ? place.isFav = true : false,
      //     )
      //     .toList();
      // emit(PlacesLoaded(places: placesV));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
  }
}
