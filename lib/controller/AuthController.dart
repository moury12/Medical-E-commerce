import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/auth_service.dart';
import 'package:medi_source_apitest/constant/enums.dart';
import 'package:medi_source_apitest/models/district_model.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:medi_source_apitest/pages/otp_verification_page.dart';
import 'package:mh_core/utils/global.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  RxString registerPhone = ''.obs;
  RxMap loginCredentials = {}.obs;
  Rx<bool> isSelected = RxBool(false);
  RxList<DistrictModel> disList = <DistrictModel>[].obs;
  RxList<SubDistrict> areaList = <SubDistrict>[].obs;
  Rx<String> selectedDistrict = ''.obs;
  Rx<String> selectedArea = ''.obs;
  @override
  void onInit() {
    getAreaData();
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getAreaData() async {
    final data = await AuthService.getAreaData();
    disList.value = data[AddressType.district] as List<DistrictModel>;
    areaList.value = data[AddressType.subdidtrict] as List<SubDistrict>;
  }
  void loginRequest(String emailOrPhone, String password, /*bool isRememberMe*/) async {
    registerPhone(emailOrPhone);
    // setLocalData(activeUserLocalKey, {
    //   "phone": emailOrPhone,
    //   "password": password,
    // });
    loginCredentials.value = {
      "phone": emailOrPhone,
      "password": password,
    };
    // getProgressDialog();
    globalLogger.d("Login Function Call");

    final accessToken = await AuthService.loginCall({
      "phone": emailOrPhone,
      "password": password,
    });
    globalLogger.d(accessToken, 'accessToken');
    if (accessToken['token'] != null && accessToken['token'].isNotEmpty) {
      // setLocalData(loginByKey, '0');
      // loginUserInfoLoad.value = accessToken['user'];
      // afterLogin(accessToken['tokenResult']);
      Get.toNamed(OtpVerificationPage.routeName);
    }
  }

  void registerationRequest(
    String name,
    String phone,
    String district_id,
    String area_id,
    String address,
    String password,
  ) async {
    registerPhone(phone);
    final isCreated = await AuthService.registerCall({
      'name': name,
      'phone': phone,
      'district_id': district_id,
      'area_id': area_id,
      'address': address,
      'password': password
    });
    if(isCreated){
      showSnackBar(msg: 'Account created successfully');
      Get.offAndToNamed(LoginPage.routeName);
    }
    else{
      showSnackBar(msg: 'faild');
    }
  }
}
