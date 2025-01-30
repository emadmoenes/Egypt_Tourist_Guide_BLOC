import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egypt_tourist_guide/core/services/shared_prefs_service.dart';
import 'package:egypt_tourist_guide/models/user_model.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<LoadProfileEvent>(_loadProfileData);
    on<UpdateProfileEvent>(_updateProfileData);
    on<ToggleEditingEvent>(_toggleEditing);
    on<TogglePasswordVisibilityEvent>(_togglePasswordProfileVisibility);
  }

  User user = User(
    fullName: 'User Name',
    email: 'user@example.com',
    password: 'Password123@',
    phoneNumber: '01###-###-####',
    address: '123 Main Street',
  );
  bool isEditing = false;

  bool isVisibleProfilePassword = false;

  // handle toggle password visibility event
  Future<void> _togglePasswordProfileVisibility(
      TogglePasswordVisibilityEvent event, Emitter<ProfileState> emit) async {
    isVisibleProfilePassword = !isVisibleProfilePassword;
    emit(PasswordVisibilityToggledState());
  }

  // handle load profile data event
  Future<void> _loadProfileData(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    // get user data from shared prefs
    try {
      final userData = await SharedPrefsService.getUserData();
      user = User.fromMap(userData);
      emit(ProfileLoadedState());
    } catch (e) {
      emit(ProfileErrorState());
    }
  }

  // handle update profile data event
  Future<void> _updateProfileData(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      await SharedPrefsService.saveUserData(
        fullName: event.user.fullName,
        email: event.user.email,
        password: event.user.password,
        phoneNumber: event.user.phoneNumber,
        address: event.user.address,
      );

      emit(ProfileUpdatedState());
      isEditing = !isEditing;
      emit(ProfileEditingToggledState());
    } catch (e) {
      emit(ProfileErrorState());
    }
  }

  Future<void> _toggleEditing(
      ToggleEditingEvent event, Emitter<ProfileState> emit) async {
    isEditing = !isEditing;
    emit(ProfileEditingToggledState());
  }
}
