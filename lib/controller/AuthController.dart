import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<bool> isSelected = RxBool(false);

  Rx<String> selectedDistrict=''.obs;
  Rx<String> selectedArea=''.obs;


}