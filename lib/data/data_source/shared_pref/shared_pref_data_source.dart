import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefDSTemp {
  // get
  String? getString(String key);

  bool? getBool(String key);

  // set
  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  // remove
  Future<bool> removeKey(String key);
}

class SharedPrefDSImpl implements SharedPrefDSTemp {
  final SharedPreferences _preferences;

  SharedPrefDSImpl(this._preferences);

  @override
  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  @override
  String? getString(String key) {
    return _preferences.getString(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  @override
  Future<bool> removeKey(String key) async {
    return await _preferences.remove(key);
  }
}
