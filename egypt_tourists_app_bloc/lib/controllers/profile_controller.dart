import 'package:egypt_tourists_app_bloc/models/user_model.dart';
import 'package:egypt_tourists_app_bloc/services/shared_prefs_service.dart';

class ProfileController {
  Future<User> loadUserData() async {
    final userData = await SharedPrefsService.getUserData();
    return User.fromMap(userData);
  }

  Future<void> updateUserData(User user) async {
    await SharedPrefsService.saveUserData(
      fullName: user.fullName,
      email: user.email,
      password: user.password,
      phoneNumber: user.phoneNumber,
      address: user.address,
    );
  }
}
