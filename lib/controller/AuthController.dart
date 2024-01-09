import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/auth_service.dart';
import 'package:medi_source_apitest/constant/enums.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/controller/user_controller.dart';
import 'package:medi_source_apitest/global.dart';
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
  bool get isLoggedIn => getLocaldata('isLoggedIn')??false;
  String get getAuthToken => getLocaldata('authToken') ?? '';
  RxString otp = ''.obs;
  RxString afterLoginRoute = HomePage.routeName.obs;
  RxMap<dynamic, dynamic> afterLoginArg = {}.obs;
  Rx<bool> isSelected = RxBool(false);
  RxList<DistrictModel> disList = <DistrictModel>[].obs;
  RxList<SubDistrict> areaList = <SubDistrict>[].obs;
  Rx<String> selectedDistrict = ''.obs;
  Rx<String> selectedArea = ''.obs;
  RxMap loginUserInfoLoad = {}.obs;
  RxBool isLogInBack = false.obs;
  bool get isFirstTime => storage.read('isFirstTime') ?? true;

  @override
  void onInit() {
    if(isLoggedIn){
      ServiceAPI.setAuthToken(getAuthToken);
      Get.put<UserController>(UserController(),permanent: true);
      Get.put<HomeController>(HomeController(),permanent: true);
      getUserInfoFromLocal();
    }
    getAreaData();
    globalLogger.d(isLoggedIn, "isLoggedIn");

    super.onInit();
  }
  void offIntroPage(){
    storage.write('isFirstTime', false);
  }
getUserInfoFromLocal(){
    final data =getLocaldata(activeUserLocalKey);
loginCredentials.value=data ?? {
  "phone": '',
  "password": '',
};
}
  Future<void> getAreaData() async {
    final data = await AuthService.getAreaData();
    disList.value = data[AddressType.district] as List<DistrictModel>;
    areaList.value = data[AddressType.subdidtrict] as List<SubDistrict>;
  }
  void loginRequest(String emailOrPhone, String password, /*bool isRememberMe*/) async {
    registerPhone(emailOrPhone);
    setLocaldata(activeUserLocalKey, {
      "phone": emailOrPhone,
      "password": password,
    });
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
      globalLogger.d(accessToken['token'],'rrttrete');
      afterLogin(accessToken['token']);
    }
    }
  }

  void afterLogin(String accessToken) {
    setLocaldata('authToken', accessToken);
    ServiceAPI.setAuthToken(accessToken);
    setLocaldata('isLoggedIn', true);
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
  void _logoutCallFunc() {
    Get.delete<UserController>(force: true);
    // setLocalData(courseCartLocalKey, []);
    Get.delete<HomeController>(force: true);
    // HomeController.to.bottomNavBarType(BottomNavBarType.home);
    setLocaldata('authToken', '');
    ServiceAPI.delAuthToken('');
    setLocaldata('isLoggedIn', false);
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
    globalLogger.d(getAuthToken);
    final isLogoutWorked = await AuthService.logoutCall(forceLogout: () {
      _logoutCallFunc();
    });
    if (isLogoutWorked) {
      _logoutCallFunc();
    }
  }
}
