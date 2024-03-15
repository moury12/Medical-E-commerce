import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/DB/db_helper.dart';
import 'package:medi_source_apitest/bindings/AuthBinding.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';
import 'package:medi_source_apitest/routes.dart';
import 'package:mh_core/services/api_service.dart';
import 'package:mh_core/utils/global.dart';

import 'pages/splash_screen.dart';
final dbHelper=DbHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
await DbHelper.initDatabase();
  }catch(e){
globalLogger.d(e);
  }
  ServiceAPI.domain('http://apitest.wiztecbd.com/');
  ServiceAPI.extraSlag('api/');
  navigatorKey = GlobalKey<NavigatorState>();
  snackbarKey = GlobalKey<ScaffoldMessengerState>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medi Source',
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppRoutes.routes(),
      initialRoute: SplashScreen.routeName,
      initialBinding: AuthBindings(),
    );
  }
}
