part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UserModel user;

  UpdateProfileEvent(this.user);
}

class ToggleEditingEvent extends ProfileEvent {}

class TogglePasswordVisibilityEvent extends ProfileEvent {}

// This event will be used in next version
class UpdateAvatarEvent extends ProfileEvent {}
