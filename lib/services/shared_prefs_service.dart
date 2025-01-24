import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _userFullNameKey = 'user_full_name';
  static const String _userEmailKey = 'user_email';
  static const String _userPasswordKey = 'user_password';
  static const String _userPhoneKey = 'user_phone';
  static const String _userProfilePicKey = 'user_profile_pic';
  static const String _userAddressKey = 'user_address';

  static Future<void> saveUserData({
    required String fullName,
    required String email,
    required String password,
    String? phoneNumber,
    String? profilePicUrl,
    String? address,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userFullNameKey, fullName);
    await prefs.setString(_userEmailKey, email);
    await prefs.setString(_userPasswordKey, password);
    if (phoneNumber != null) await prefs.setString(_userPhoneKey, phoneNumber);
    if (profilePicUrl != null)
      await prefs.setString(_userProfilePicKey, profilePicUrl);
    if (address != null) await prefs.setString(_userAddressKey, address);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'fullName': prefs.getString(_userFullNameKey) ?? '',
      'email': prefs.getString(_userEmailKey) ?? '',
      'password': prefs.getString(_userPasswordKey) ?? '',
      'phoneNumber': prefs.getString(_userPhoneKey),
      'profilePicUrl': prefs.getString(_userProfilePicKey),
      'address': prefs.getString(_userAddressKey),
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userFullNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userPasswordKey);
    await prefs.remove(_userPhoneKey);
    await prefs.remove(_userProfilePicKey);
    await prefs.remove(_userAddressKey);
  }

  static Future<void> saveTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", theme);
  }

  static Future<String?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString("theme");
    return theme;
  }
}
