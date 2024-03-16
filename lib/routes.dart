import 'package:get/get.dart';
import 'package:medi_source_apitest/pages/create_new_password_page.dart';
import 'package:medi_source_apitest/pages/flash_product_page.dart';
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
    GetPage(name: OtpVerificationPage.routeName, page:() => const OtpVerificationPage(), ),
    GetPage(name: HomePage.routeName, page:() => const HomePage(), ),
    GetPage(name: LoginPage.routeName, page:() => const LoginPage(), ),
    GetPage(name: SearchScreen.routeName, page:() => const SearchScreen(), ),
    GetPage(name: ProductFlashScreen.routeName, page:() => const ProductFlashScreen(), ),
    GetPage(name: ForgotPasswordPage.routeName, page:() => const ForgotPasswordPage(), ),
    GetPage(name: CreateNewPasswordPage.routeName, page:() => const CreateNewPasswordPage(), ),
    GetPage(name: '/', page:() => const SplashScreen(), ),
  ];
}