import 'package:resideo_eshopping/services/shared_preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final Future<SharedPreferences> _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  Future<String> get authToken async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.auth_token);
    });
  }

  Future<void> saveAuthToken(String authToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, authToken);
    });
  }

  Future<void> removeAuthToken() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.auth_token);
    });
  }

  Future<bool> get isLoggedIn async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.auth_token) ?? false;
    });
  }
}