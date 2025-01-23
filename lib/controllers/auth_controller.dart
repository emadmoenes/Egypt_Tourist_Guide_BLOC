import 'package:egypt_tourist_guide/models/user_model.dart';
import 'package:egypt_tourist_guide/services/shared_prefs_service.dart';

class AuthController {
  User? _currentUser;

  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
    String? phoneNumber,
    String? profilePicUrl,
    String? address,
  }) async {
    _currentUser = User(
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      profilePicUrl: profilePicUrl,
      address: address,
    );
    await SharedPrefsService.saveUserData(
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      profilePicUrl: profilePicUrl,
      address: address,
    );
  }

  Future<bool> login(String email, String password) async {
    final userData = await SharedPrefsService.getUserData();
    if (userData['email'] == email && userData['password'] == password) {
      _currentUser = User(
        fullName: userData['fullName'],
        email: userData['email'],
        password: userData['password'],
        phoneNumber: userData['phoneNumber'],
        profilePicUrl: userData['profilePicUrl'],
        address: userData['address'],
      );
      return true;
    }
    return false;
  }

  Future<void> updateUserProfile({
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    String? profilePicUrl,
    String? address,
  }) async {
    if (_currentUser != null) {
      if (fullName != null) _currentUser!.fullName = fullName;
      if (email != null) _currentUser!.email = email;
      if (password != null) _currentUser!.password = password;
      if (phoneNumber != null) _currentUser!.phoneNumber = phoneNumber;
      if (profilePicUrl != null) _currentUser!.profilePicUrl = profilePicUrl;
      if (address != null) _currentUser!.address = address;

      await SharedPrefsService.saveUserData(
        fullName: _currentUser!.fullName,
        email: _currentUser!.email,
        password: _currentUser!.password,
        phoneNumber: _currentUser!.phoneNumber,
        profilePicUrl: _currentUser!.profilePicUrl,
        address: _currentUser!.address,
      );
    }
  }

  User? getCurrentUser() {
    return _currentUser;
  }

  Future<void> logout() async {
    _currentUser = null;
    await SharedPrefsService.clearUserData();
  }
}
