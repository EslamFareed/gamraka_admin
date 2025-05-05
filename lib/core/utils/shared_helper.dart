import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> loginAsAdmin(String email, String id) async {
    await prefs.setString("email", email);
    await prefs.setString("id", id);

    await prefs.setBool("isLogin", true);
  }

  static bool isLogin() => prefs.getBool("isLogin") ?? false;

  static String getAdminEmail() => prefs.getString("email") ?? "";
}
