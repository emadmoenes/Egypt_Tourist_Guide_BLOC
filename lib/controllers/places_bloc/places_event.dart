part of 'places_bloc.dart';

@immutable
sealed class PlacesEvent {}

class LoadPlacesEvent extends PlacesEvent {}

class LoadMorePlacesEvent extends PlacesEvent {}

class ToggleFavouriteEvent extends PlacesEvent {
  final int placeId;
  ToggleFavouriteEvent(this.placeId);
}

