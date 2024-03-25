import 'package:get/get.dart';
import 'package:medi_source_apitest/pages/cart_page.dart';
import 'package:medi_source_apitest/pages/cart_page.dart';
import 'package:medi_source_apitest/pages/create_new_password_page.dart';
import 'package:medi_source_apitest/pages/flash_product_page.dart';
import 'package:medi_source_apitest/pages/forgot_password_page.dart';
import 'package:medi_source_apitest/pages/home_page.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:medi_source_apitest/pages/order_list_page.dart';
import 'package:medi_source_apitest/pages/order_list_page.dart';
import 'package:medi_source_apitest/pages/otp_verification_page.dart';
import 'package:medi_source_apitest/pages/profile/edit_profile_page.dart';
import 'package:medi_source_apitest/pages/profile/edit_profile_page.dart';
import 'package:medi_source_apitest/pages/profile_page.dart';
import 'package:medi_source_apitest/pages/profile_page.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';
import 'package:medi_source_apitest/pages/search_page.dart';

import 'pages/splash_screen.dart';

class AppRoutes{
  static routes()=>[
    GetPage(name: SignupScreen.routeName, page:() => SignupScreen(), ),
    GetPage(name: OtpVerificationPage.routeName, page:() => const OtpVerificationPage(), ),
    GetPage(name: HomePage.routeName, page:() => const HomePage(), ),
    GetPage(name: EditProfileScreen.routeName, page:() => const EditProfileScreen(), ),
    GetPage(name: CartScreen.routeName, page:() => const CartScreen(), ),
    GetPage(name: OrderListScreen.routeName, page:() => const OrderListScreen(), ),
    GetPage(name: ProfileScreen.routeName, page:() => const ProfileScreen(), ),
    GetPage(name: LoginPage.routeName, page:() => const LoginPage(), ),
    GetPage(name: SearchScreen.routeName, page:() => const SearchScreen(), ),
    GetPage(name: ProductFlashScreen.routeName, page:() => const ProductFlashScreen(), ),
    GetPage(name: ForgotPasswordPage.routeName, page:() => const ForgotPasswordPage(), ),
    GetPage(name: CreateNewPasswordPage.routeName, page:() => const CreateNewPasswordPage(), ),
    GetPage(name: '/', page:() => const SplashScreen(), ),
  ];
}