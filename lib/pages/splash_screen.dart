import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/pages/home_page.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName='/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      Get.offAndToNamed(AuthController.to.isLoggedIn?HomePage.routeName:LoginPage.routeName);
    });
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator()
            // ElevatedButton(onPressed: () => Get.toNamed(SignupScreen.routeName), child: Text('Reg')),
            // ElevatedButton(onPressed: () => Get.toNamed(HomePage.routeName), child: Text('home'))
          ],
        ),
      ),
    );
  }
}
