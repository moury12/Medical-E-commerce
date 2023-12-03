import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/auth_service.dart';
import 'package:medi_source_apitest/constant/enums.dart';
import 'package:medi_source_apitest/models/district_model.dart';

class AuthController extends GetxController{
  static AuthController get to => Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<bool> isSelected = RxBool(false);
RxList<DistrictModel> disList =<DistrictModel>[].obs;
RxList<SubDistrict> areaList =<SubDistrict>[].obs;
  Rx<String> selectedDistrict=''.obs;
  Rx<String> selectedArea=''.obs;
@override
  void onInit() {
  getAreaData();
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> getAreaData () async{
  final data =  await AuthService.getAreaData();
  disList.value=data[AddressType.district] as List<DistrictModel>;
  areaList.value=data[AddressType.subdidtrict] as List<SubDistrict>;
  }

}