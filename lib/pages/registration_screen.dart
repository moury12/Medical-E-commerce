import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/dropdown/custom_dropdown.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

import '../constant/colorConstant.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "/signup";
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isSelected = false;

  String? selectedDistrict;
  String? selectedArea;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up'),
        ),
        body: Column(
          children: [
            CustomTextField(
              enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
              borderWidth: .8,
              focusColor: AppColors.kPrimaryColor.withOpacity(.8),
              marginVertical: 0,
              marginHorizontal: 0,
              controller: nameController,
              labelText: 'Shop Full Name',
              hintText: 'Enter your shop full name',
            ),
            CustomTextField(
              enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
              borderWidth: .8,
              focusColor: AppColors.kPrimaryColor.withOpacity(.8),
              marginVertical: 0,
              marginHorizontal: 0,
              controller: phoneController,
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
              dwItems: AuthController.to.disList,
              type: DropdownListType.object,
              valueKey: 'id',
              viewKey: 'name',
              dwValue: selectedDistrict,
              onChange: (val) {
                selectedDistrict = val;
                setState(() {});
              },
            ),
            TitleDropdown(
                borderColor: AppColors.kPrimaryColor.withOpacity(.8),
                hintText: 'Select Area',
                marginHorizontal: 0,
                marginVertical: 0,
                rightIconBgColor: Colors.transparent,
                rightIconColor: AppColors.kPrimaryColor,
                title: 'Area',
                dwItems: AuthController.to.areaList
                    .where((p0) => selectedDistrict != null
                        ? p0.districtId == selectedDistrict!
                        : true)
                    .toList(),
                type: DropdownListType.object,
                valueKey: 'id',
                viewKey: 'name',
                dwValue: selectedArea,
                onChange: (val) {
                  selectedArea = val;
                  setState(() {});
                }),
            CustomTextField(
              enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
              borderWidth: .8,
              focusColor: AppColors.kPrimaryColor.withOpacity(.8),
              marginVertical: 0,
              marginHorizontal: 0,
              controller: addressController,
              labelText: 'Address',
              hintText: 'Enter your address number',
            ),
            CustomTextField(
              enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
              borderWidth: .8,
              focusColor: AppColors.kPrimaryColor.withOpacity(.8),
              marginVertical: 0,
              marginHorizontal: 0,
              controller: passwordController,
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

    if (nameController.text.isEmpty ||
    // emailController.text.isEmpty &&
    phoneController.text.isEmpty ||
    selectedDistrict == null ||
    selectedArea == null ||
    addressController.text.isEmpty ||
    passwordController.text
        .isEmpty /*||
                        confirmPasswordController.text.isEmpty*/
    ) {
    showSnackBar(msg: 'All Fields are required!');
    }else{
AuthController.to.registerationRequest( nameController.text,
    phoneController.text,
    selectedDistrict!,
    selectedArea!,
    addressController.text,
    passwordController.text);
    }

    },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have and account?'),
               TextButton(
                  child: Text('Login'),
                  onPressed: () {
                    Get.offNamed(LoginPage.routeName);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
