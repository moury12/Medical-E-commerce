import 'package:get/get.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:medi_source_apitest/pages/otp_verification_page.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';

import 'pages/splash_screen.dart';

class AppRoutes{
  static routes()=>[
    GetPage(name: SignupScreen.routeName, page:() => SignupScreen(), ),
    GetPage(name: OtpVerificationPage.routeName, page:() => OtpVerificationPage(), ),
    GetPage(name: LoginPage.routeName, page:() => LoginPage(), ),
    GetPage(name: '/', page:() => SplashScreen(), ),
  ];
}