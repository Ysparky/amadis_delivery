import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal();

  SharedPreferences _preferences;

  void initPrefs() async {
    _preferences = await SharedPreferences.getInstance();
  }

  int get userId {
    return _preferences.getInt('userId') ?? 0;
  }

  set userId(int userId) {
    _preferences.setInt('userId', userId);
  }

  bool get isLoggedIn {
    return _preferences.getBool('isLoggedIn') ?? false;
  }

  set isLoggedIn(bool isLogged) {
    _preferences.setBool('isLoggedIn', isLogged);
  }

  int get activeRouteIndex {
    return _preferences.getInt('activeRouteIndex') ?? -1;
  }

  set activeRouteIndex(int activeRouteIndex) {
    _preferences.setInt('activeRouteIndex', activeRouteIndex);
  }

  void removeAll() {
    _preferences.remove('userId');
    _preferences.remove('isLoggedIn');
  }
}
