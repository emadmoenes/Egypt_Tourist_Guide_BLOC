part of 'places_bloc.dart';

abstract class PlacesState {}

final class PlacesInitial extends PlacesState {}

final class PlacesLoading extends PlacesState {}

final class PlacesLoaded extends PlacesState {
  final List<PlacesModel> places;
  PlacesLoaded({required this.places});
}

final class PlacesError extends PlacesState {}
