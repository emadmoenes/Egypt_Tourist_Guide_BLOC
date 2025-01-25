import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _userFullNameKey = 'user_full_name';
  static const String _userEmailKey = 'user_email';
  static const String _userPasswordKey = 'user_password';
  static const String _userPhoneKey = 'user_phone';
  static const String _userProfilePicKey = 'user_profile_pic';
  static const String _userAddressKey = 'user_address';
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /*-------------- Save user data -----------*/
  static Future<void> saveUserData({
    required String fullName,
    required String email,
    required String password,
    String? phoneNumber,
    String? profilePicUrl,
    String? address,
  }) async {
    await sharedPreferences.setString(_userFullNameKey, fullName);
    await sharedPreferences.setString(_userEmailKey, email);
    await sharedPreferences.setString(_userPasswordKey, password);
    if (phoneNumber != null) {
      await sharedPreferences.setString(_userPhoneKey, phoneNumber);
    }
    if (profilePicUrl != null) {
      await sharedPreferences.setString(_userProfilePicKey, profilePicUrl);
    }
    if (address != null) {
      await sharedPreferences.setString(_userAddressKey, address);
    }
  }

  /*-------------- Get user data from shared prefs ---------------*/
  static Future<Map<String, dynamic>> getUserData() async {
    return {
      'fullName': sharedPreferences.getString(_userFullNameKey) ?? '',
      'email': sharedPreferences.getString(_userEmailKey) ?? '',
      'password': sharedPreferences.getString(_userPasswordKey) ?? '',
      'phoneNumber': sharedPreferences.getString(_userPhoneKey),
      'profilePicUrl': sharedPreferences.getString(_userProfilePicKey),
      'address': sharedPreferences.getString(_userAddressKey),
    };
  }

  /*-------------- Clear user data ---------------*/
  static Future<void> clearUserData() async {
    await sharedPreferences.remove(_userFullNameKey);
    await sharedPreferences.remove(_userEmailKey);
    await sharedPreferences.remove(_userPasswordKey);
    await sharedPreferences.remove(_userPhoneKey);
    await sharedPreferences.remove(_userProfilePicKey);
    await sharedPreferences.remove(_userAddressKey);
  }

  /*-------------- Save string data ---------------*/
  static Future<bool> saveStringData(
      {required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
    return true;
  }

  /*------------ Get String data from shared prefs --------------*/
  static Future<String?> getStringData({required String key}) async {
    String? value = sharedPreferences.getString(key);
    return value;
  }
}
