import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SharedPreferenceService {
  getSharedPreferencesInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLoggedIn =
        prefs.getBool(Constants.isLoggedInStatusSharedPrefrence);
    print("read called");
    if (isLoggedIn == null) {
      return false;
    }
    return isLoggedIn;
  }

  updateLoginStatus(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.isLoggedInStatusSharedPrefrence, status);
    print("write called");
  }
}
