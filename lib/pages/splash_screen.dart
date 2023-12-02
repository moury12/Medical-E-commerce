import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName='/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Get.toNamed(SignupScreen.routeName), child: Text('Reg'))
          ],
        ),
      ),
    );
  }
}
