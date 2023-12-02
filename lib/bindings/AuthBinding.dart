import 'package:get/get.dart';

import '../controller/AuthController.dart';

class AuthBindings extends Bindings{
void dependencies(){
  Get.put<AuthController>(AuthController(),permanent: true );
}
}