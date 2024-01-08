import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';

import '../controller/AuthController.dart';

class AuthBindings extends Bindings{
void dependencies(){
  Get.put<AuthController>(AuthController(),permanent: true );
}
}