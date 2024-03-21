import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:medi_source_apitest/DB/db_helper.dart';
import 'package:medi_source_apitest/api-service/auth_service.dart';
import 'package:medi_source_apitest/constant/enums.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/controller/user_controller.dart';
import 'package:medi_source_apitest/main.dart';
import 'package:medi_source_apitest/models/district_model.dart';
import 'package:medi_source_apitest/pages/create_new_password_page.dart';
import 'package:medi_source_apitest/pages/home_page.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:medi_source_apitest/pages/otp_verification_page.dart';
import 'package:mh_core/services/api_service.dart';
import 'package:mh_core/utils/global.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  RxString registerPhone = ''.obs;
  RxMap loginCredentials = {}.obs;
  RxString otp = ''.obs;
  RxString afterLoginRoute = OtpVerificationPage.routeName.obs;
  RxMap<dynamic, dynamic> afterLoginArg = {}.obs;
  Rx<bool> isSelected = RxBool(false);
  RxList<DistrictModel> disList = <DistrictModel>[].obs;
  RxList<SubDistrict> areaList = <SubDistrict>[].obs;
  Rx<String> selectedDistrict = ''.obs;
  Rx<String> selectedArea = ''.obs;
  RxMap loginUserInfoLoad = {}.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isLogInBack = false.obs;
  String? token;
  @override
  void onInit() {
   
    getAreaData();
getAccessToken();
    super.onInit();
  }


  Future<void> getAreaData() async {
    final data = await AuthService.getAreaData();
    disList.value = data[AddressType.district] as List<DistrictModel>;
    areaList.value = data[AddressType.subdidtrict] as List<SubDistrict>;
  }
  void loginRequest(String emailOrPhone, String password, /*bool isRememberMe*/) async {
    registerPhone(emailOrPhone);

    loginCredentials.value = {
      "phone": emailOrPhone,
      "password": password,
    };
    // getProgressDialog();
    globalLogger.d("Login Function Call");

    final data = await AuthService.loginCall({
      "phone": emailOrPhone,
      "password": password,
    });
    globalLogger.d(data, 'data');
    if (data['token'] != null && data['token'].isNotEmpty) {
      var token =data['token'];
      afterLogin(token);     /* Get.toNamed(OtpVerificationPage.routeName);*/
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
  void registerOtpVerification([bool isFromChangePassword= false]) async{
    final accessToken = await AuthService.verifyAfterLoginOtp
      ({'phone':registerPhone.value,'otp':otp.value});
    globalLogger.d(accessToken, 'accessToken');
    if(accessToken['token']!=null&&accessToken['token'].isNotEmpty){
    if(isFromChangePassword){
      showSnackBar(msg: 'Otp Matched successfully!!');
      Get.toNamed(CreateNewPasswordPage.routeName);
    }
    else{
      /*globalLogger.d(accessToken['token'],'rrttrete');
      afterLogin(accessToken['token']);*/
    }
    }
  }

  void afterLogin(String accessToken) {
    DbHelper.insertLoginData(accessToken);
    isLoggedIn.value =true;
    ServiceAPI.setAuthToken(accessToken);
    Get.put<UserController>(UserController(),permanent: true);
    Get.put<HomeController>(HomeController(),permanent: true);
  loginAfterRoute();
  }
  loginAfterRoute() {
    // if (isLogInBack.value) {
    //   Get.back();
    // } else {
    Get.offAndToNamed(afterLoginRoute.value, arguments: afterLoginArg);
    // }
  }
  setAfterLogInRoute({String? routeName, dynamic arg, bool isBack = true}) {
    afterLoginRoute(routeName ?? '');
    afterLoginArg(arg);
    isLogInBack(isBack);
  }
  Future<void> forgetpassword(String phone, [bool isResend= false]) async{
    registerPhone(phone);
    bool issendOtp=await AuthService.forgotPassword({
     'phone' : phone
    });
    if(issendOtp){
      showSnackBar(msg: 'Otp send');
      if(!isResend){
        Get.offAndToNamed(OtpVerificationPage.routeName);
      }
    }
  }
  void verifyPassword(String password , String cPAssword)async{
    bool isVerified= await AuthService.resetPassword({
      'phone':registerPhone.value,
          'new_password':password,
    'confirm_password':cPAssword
    });
    if(isVerified){
      showSnackBar(msg: 'Verified successfuly');
      Get.offAndToNamed(LoginPage.routeName);
    }
  }
  void getAccessToken() async {
    token = await DbHelper.getAccessToken();
    if (token != null) {
      ServiceAPI.setAuthToken(token!);
globalLogger.d(ServiceAPI.getToken,'Auth token');
      isLoggedIn.value = true;
      Get.put<HomeController>(HomeController(), permanent: true);
      Get.put<UserController>(UserController(), permanent: true);
      globalLogger.d(token,'Access Token');
    } else {
      isLoggedIn.value = false;
    }
  }
  void _logoutCallFunc() {
    Get.delete<UserController>(force: true);
    // setLocalData(courseCartLocalKey, []);
    Get.delete<HomeController>(force: true);
    // HomeController.to.bottomNavBarType(BottomNavBarType.home);
    ServiceAPI.delAuthToken('');
    Get.offAllNamed('/');
  }

  Future<void> logout() async {
    /*mh.showSnackBar(
      msg: 'Logging Out ...',
      // textColor: Colors.red,
      *//*bgColor: Colors.red*//*
    );*/
    // _logoutCallFunc();

    if (is401Call) {
      is401Call = false;
    }
    final isLogoutWorked = await AuthService.logoutCall(forceLogout: () {
      _logoutCallFunc();
    });
    if (isLogoutWorked) {
      _logoutCallFunc();
    }
  }
}
