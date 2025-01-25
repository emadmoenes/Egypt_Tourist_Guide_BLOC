import 'package:egypt_tourist_guide/models/user_model.dart';
import 'package:egypt_tourist_guide/services/shared_prefs_service.dart';

class AuthController {
  User? _currentUser;

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
}
