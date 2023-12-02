import 'package:get/get.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';

import 'pages/splash_screen.dart';

class AppRoutes{
  static routes()=>[
    GetPage(name: SignupScreen.routeName, page:() => SignupScreen(), ),
    GetPage(name: '/', page:() => SplashScreen(), ),
  ];
}