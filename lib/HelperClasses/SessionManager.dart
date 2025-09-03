
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String userIdKey = "userId";

  // var userId;
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(userIdKey);
    return userId != null && userId.isNotEmpty;
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
  }
}
