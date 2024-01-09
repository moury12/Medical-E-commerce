import 'package:get/get.dart';
import 'package:medi_source_apitest/pages/create_new_password_page.dart';
import 'package:medi_source_apitest/pages/forgot_password_page.dart';
import 'package:medi_source_apitest/pages/home_page.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:medi_source_apitest/pages/otp_verification_page.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';
import 'package:medi_source_apitest/pages/search_page.dart';

import 'pages/splash_screen.dart';

class AppRoutes{
  static routes()=>[
    GetPage(name: SignupScreen.routeName, page:() => SignupScreen(), ),
    GetPage(name: OtpVerificationPage.routeName, page:() => OtpVerificationPage(), ),
    GetPage(name: HomePage.routeName, page:() => HomePage(), ),
    GetPage(name: LoginPage.routeName, page:() => LoginPage(), ),
    GetPage(name: SearchScreen.routeName, page:() => SearchScreen(), ),
    GetPage(name: ForgotPasswordPage.routeName, page:() => ForgotPasswordPage(), ),
    GetPage(name: CreateNewPasswordPage.routeName, page:() => CreateNewPasswordPage(), ),
    GetPage(name: '/', page:() => SplashScreen(), ),
  ];
}