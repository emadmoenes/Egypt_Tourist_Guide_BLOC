part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final User user;

  UpdateProfileEvent(this.user);
}

class ToggleEditingEvent extends ProfileEvent {}

class TogglePasswordVisibilityEvent extends ProfileEvent {}

class UpdateAvatarEvent extends ProfileEvent {}
