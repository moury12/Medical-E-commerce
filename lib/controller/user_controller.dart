import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/user_service.dart';
import 'package:medi_source_apitest/models/user_model.dart';

class UserController extends GetxController{
static UserController  get to =>Get.find();
Rx<UserModel> userInfo =UserModel().obs;
@override
  void onInit() {
  getUserProfileData();
    super.onInit();
  }
void getUserProfileData() async{
  userInfo.value = await UserService.getProfileData();
}
}