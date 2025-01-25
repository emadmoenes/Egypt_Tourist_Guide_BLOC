part of 'places_bloc.dart';

@immutable
sealed class PlacesEvent {}

class LoadPlacesEvent extends PlacesEvent {}

class LoadMorePlacesEvent extends PlacesEvent {}

class ToggleFavouriteEvent extends PlacesEvent {
  final PlacesModel place;
  final bool isArabic;

  ToggleFavouriteEvent(this.place, this.isArabic);
}

class ChangeBottomNavigationIndexEvent extends PlacesEvent {
  final int index;
  ChangeBottomNavigationIndexEvent(this.index);
}
