import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_track_app/core/cache/shared_not_initialize.dart';

enum SharedKeys { dates, weights, hello }

class SharedManager {
  SharedPreferences? preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> checkFirstLogin() async {
    _checkPreferences();
    if (hasKey(SharedKeys.hello)) {
      return false;
    } else {
      await preferences?.setBool(SharedKeys.hello.name, true);
      return true;
    }
  }

  void _checkPreferences() {
    if (preferences == null) throw SharedNotInitializeException();
  }

  Future<void> saveStringItems(SharedKeys key, List<String> value) async {
    _checkPreferences();
    await preferences?.setStringList(key.name, value);
  }

  List<String>? getStringItems(SharedKeys key) {
    _checkPreferences();
    return preferences?.getStringList(key.name);
  }

  Future<bool> removeItem(SharedKeys key) async {
    _checkPreferences();
    return (await preferences?.remove(key.name)) ?? false;
  }

  bool hasKey(SharedKeys key) {
    _checkPreferences();
    return (preferences?.containsKey(key.name) ?? false);
  }
}
