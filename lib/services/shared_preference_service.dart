import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static late SharedPreferences _prefs;

  SharedPreferenceService._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    _prefs.setString(key, value);
  }

  static String getString(
    String key,
  ) {
    return _prefs.getString(key) ?? '';
  }

  static setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  static bool getBool(
    String key,
  ) {
    return _prefs.getBool(key) ?? false;
  }
}
