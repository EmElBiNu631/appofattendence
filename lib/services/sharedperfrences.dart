
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const _keyUsername = 'userName';
  static const _keyEmail = 'userEmail';
  static const _keyRole = 'userRole';

  static Future<void> saveUserDetails({
    required String username,
    String? email,
    String? role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    if (email != null) await prefs.setString(_keyEmail, email);
    if (role != null) await prefs.setString(_keyRole, role);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRole);
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyRole);
  }
}
