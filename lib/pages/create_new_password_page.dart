import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/constant/colorConstant.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/controller/user_controller.dart';
import 'package:medi_source_apitest/shared_widgets/custom_sized_box.dart';
import 'package:medi_source_apitest/theme_data.dart';

import 'package:mh_core/utils/global.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});
  static const String routeName = '/new_password';
  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoggedIn = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isLoggedIn = (Get.arguments != null && Get.arguments == 'logged in');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isLoggedIn ? 'Change Password' : 'Create New Password',
              style: AppTheme.textStyleSemiBoldPrimary24,
            ),
            if (!isLoggedIn) CustomSizedBox.space12H,
            if (!isLoggedIn)
              const Text(
                'Your new password must be different from previously used passwords',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (isLoggedIn) CustomSizedBox.space16H,
            if (isLoggedIn)
              CustomTextField(
                enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
                borderWidth: .8,
                focusColor: AppColors.kPrimaryColor.withOpacity(.8),
                marginVertical: 0,
                marginHorizontal: 0,
                controller: oldPasswordController,
                labelText: 'Old Password',
                hintText: 'Enter your Old password',
                isPassword: true,
                obscureText: true,
                suffixIconColor: AppColors.kPrimaryColor,
              ),
            CustomSizedBox.space16H,
            CustomTextField(
              enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
              borderWidth: .8,
              focusColor: AppColors.kPrimaryColor.withOpacity(.8),
              marginVertical: 0,
              marginHorizontal: 0,
              controller: passwordController,
              labelText: isLoggedIn ? "New Password" : 'Password',
              hintText: 'Enter your password',
              isPassword: true,
              obscureText: true,
              suffixIconColor: AppColors.kPrimaryColor,
            ),
            CustomSizedBox.space12H,
            CustomTextField(
              enableBorderColor: AppColors.kPrimaryColor.withOpacity(.8),
              borderWidth: .8,
              focusColor: AppColors.kPrimaryColor.withOpacity(.8),
              marginVertical: 0,
              marginHorizontal: 0,
              obscureText: true,
              controller: confirmPasswordController,
              labelText:
                  isLoggedIn ? 'Confirm New Password' : 'Confirm Password',
              hintText: 'Enter your password',
              suffixIconColor: AppColors.kPrimaryColor,
              isPassword: true,
            ),
            CustomSizedBox.space4H,
            const Row(
              children: [
                Icon(
                  Icons.error_outline_outlined,
                  size: 18,
                ),
                CustomSizedBox.space4W,
                Text(
                  'Password must be more than 8 digit',
                  style: AppTheme.textStyleNormalBlack12,
                ),
              ],
            ),
            CustomButton(
              marginHorizontal: 0,
              label: 'Reset Password',
              onPressed: () {
                if (isLoggedIn) {
                  if (passwordController.text.isEmpty ||
                      confirmPasswordController.text
                          .isEmpty||oldPasswordController.text.isEmpty) {
                    showSnackBar(msg: 'All fields required');
                  }
                  else{
                    final body ={
                      'phone':UserController.to.userInfo.value.phone??'',
                      'old_password':oldPasswordController.text,
                      'new_password':passwordController.text,
                      'confirm_password':confirmPasswordController.text
                    };
                    UserController.to.changePasswordCall(body);
                  }
                } else {
                  if (passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    showSnackBar(msg: 'All fields required');
                  } else {
                    AuthController.to.verifyPassword(passwordController.text,
                        confirmPasswordController.text);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
