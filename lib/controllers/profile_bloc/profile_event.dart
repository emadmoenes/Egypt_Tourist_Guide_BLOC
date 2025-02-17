part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UserModel user;

  UpdateProfileEvent(this.user);
}

// class UpdateProfileImageFromCamEvent extends ProfileEvent{}
// class UpdateProfileImageFromGallEvent extends ProfileEvent{}
class RemoveProfileImageEvent extends ProfileEvent{}

class ToggleEditingEvent extends ProfileEvent {}

class TogglePasswordVisibilityEvent extends ProfileEvent {}

class UpdateAvatarEvent extends ProfileEvent {
  final bool isFromCamera;
  UpdateAvatarEvent(this.isFromCamera);
}
