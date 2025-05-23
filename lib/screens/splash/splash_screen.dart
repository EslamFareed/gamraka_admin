import 'package:flutter/material.dart';

import 'package:gamraka_admin/core/utils/app_functions.dart';
import 'package:gamraka_admin/core/utils/shared_helper.dart';
import 'package:gamraka_admin/screens/dashboard/dashboard_screen.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        context.goOffAll(
          SharedHelper.isLogin() ? DashboardScreen() : LoginScreen(),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/icon.png"),
            Text(
              "EduGate ADMIN",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
