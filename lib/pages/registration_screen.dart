import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/dropdown/custom_dropdown.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

import '../constant/colorConstant.dart';

class SignupScreen extends StatelessWidget {
static const String routeName ="/signup";
   SignupScreen({super.key});
final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up'),),

      body:
      Obx(
  () {
          return Column(
            children: [
              CustomTextField(
                enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
                borderWidth: .8,
                focusColor: AppColors.kPrimaryColor.withOpacity(.8),
                marginVertical: 0,
                marginHorizontal: 0,
                controller: controller.nameController,
                labelText: 'Shop Full Name',
                hintText: 'Enter your shop full name',
              ),
              CustomTextField(
                enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
                borderWidth: .8,
                focusColor: AppColors.kPrimaryColor.withOpacity(.8),
                marginVertical: 0,
                marginHorizontal: 0,
                controller: controller.phoneController,
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              TitleDropdown(
                  borderColor: AppColors.kPrimaryColor.withOpacity(.8),
                  hintText: 'Select District',
                  marginHorizontal: 0,
                  marginVertical: 0,
                  rightIconBgColor: Colors.transparent,
                  rightIconColor: AppColors.kPrimaryColor,
                  title: 'District',
                  //dwItems: AuthController.to.districtList,
                  type: DropdownListType.object,
                  valueKey: 'id',
                  viewKey: 'name',
                  dwValue: controller.selectedDistrict.value,
                  onChange: (val) {
                    controller.selectedDistrict.value = val;

                  }, dwItems: [],),
              TitleDropdown(
                  borderColor: AppColors.kPrimaryColor.withOpacity(.8),
                  hintText: 'Select Area',
                  marginHorizontal: 0,
                  marginVertical: 0,
                  rightIconBgColor: Colors.transparent,
                  rightIconColor: AppColors.kPrimaryColor,
                  title: 'Area',
                  dwItems:[],
                  // AuthController.to.areaList
                  //     .where((p0) => selectedDistrict = null
                  //     ? p0.districtId == selectedDistrict
                  //     : true)
                  //     .toList(),
                  type: DropdownListType.object,
                  valueKey: 'id',
                  viewKey: 'name',
                  dwValue: controller.selectedArea.value,
                  onChange: (val) {
                    controller.selectedArea.value = val;

                  }),
              CustomTextField(
                enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
                borderWidth: .8,
                focusColor: AppColors.kPrimaryColor.withOpacity(.8),
                marginVertical: 0,
                marginHorizontal: 0,
                controller: controller.addressController,
                labelText: 'Address',
                hintText: 'Enter your address number',
              ),
              CustomTextField(
                enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
                borderWidth: .8,
                focusColor: AppColors.kPrimaryColor.withOpacity(.8),
                marginVertical: 0,
                marginHorizontal: 0,
                controller: controller.passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                suffixIconColor: AppColors.kPrimaryColor,
                isPassword: true,
                obscureText: true,
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     CustomCheckBox(
              //         label: 'I agree to the',
              //         value: isSelected,
              //         onChange: (val) {
              //           isSelected = val;
              //           setState(() {});
              //         }),
              //     CustomTextButton(
              //       label: 'Privacy Policy',
              //       onTap: () {
              //         Get.toNamed(TermsPrivacyPage.routeName,
              //             arguments: {ArgumentType.from: FromArgument.privacy});
              //       },
              //     ),
              //   ],
              // ),
              CustomButton(
                marginHorizontal: 0,
                marginVertical: 0,
                label: 'Signup',
                onPressed: () {

                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have and account?'),
                  // CustomTextButton(
                  //   label: 'Login',
                  //   onTap: () {
                  //     Get.offNamed(LoginPage.routeName);
                  //   },
                  // ),
                ],
              ),
            ],
          );
        }
      ),
    );

  }
}
