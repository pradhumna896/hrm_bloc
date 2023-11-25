import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SharedPreferences? preferences;
  static const _user = "access_token";
  static const _token = "token";
  static const _userId = "userId";
  static const _role = "role";


  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static dynamic setUser(String user) {
    return preferences!.setString(_user, user);
  }

  static String? getUser() {
    return preferences!.getString(_user);
  }
  static dynamic setUserId(String userId) {
    return preferences!.setString(_userId, userId);
  }

  static String? getUserId() {
    return preferences!.getString(_userId);
  }

  static dynamic setToken(String token) {
    return preferences!.setString(_token, token);
  }

  static dynamic getToken() {
    return preferences!.getString(_token);
  }
  static dynamic setRole(String role) {
    return preferences!.setString(_role, role);
  }

  static dynamic getRole() {
    return preferences!.getString(_role);
  }

  static dynamic removeToken() {
    return preferences!.remove(_token);
  }
}