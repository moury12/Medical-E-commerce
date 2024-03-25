import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/user_service.dart';
import 'package:medi_source_apitest/models/user_model.dart';
import 'package:mh_core/utils/global.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();
  Rx<UserModel> userInfo = UserModel().obs;
  Rx<bool> changePassword = false.obs;
  @override
  void onInit() {
    getUserProfileData();
    super.onInit();
  }

  void getUserProfileData() async {
    userInfo.value = await UserService.getProfileData();
  }

  void updateUserProfileCall(dynamic body) async {
    final isUpdated = await UserService.updateProfileCall(body);
    if (isUpdated) {
      getUserProfileData();
      Get.back();
      showSnackBar(msg: 'profile updated successfully');
    } else {
      showSnackBar(msg: 'Something went Wrong');
    }
  }
  void changePasswordCall(dynamic body) async{
    final isChange = await UserService.changePassword(body);
    if(isChange){
      Get.back();
      showSnackBar(msg: 'Password Change successfully');
    }
    else{
      showSnackBar(msg: 'something went wrong');
    }
  }
}
