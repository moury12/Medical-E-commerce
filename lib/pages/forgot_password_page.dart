import 'package:flutter/material.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/theme_data.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

import '../shared_widgets/custom_sized_box.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  static const String routeName = '/forgot_pass_page';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomSizedBox.space16H,
              const Text(
                'Forgot Password!',
                style: AppTheme.textStyleSemiBoldPrimary24,
              ),
              CustomSizedBox.space16H,
              const Text(
                'Please enter the phone number associated with your account to verify.',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              CustomSizedBox.space16H,
              CustomTextField(
                marginVertical: 0,
                marginHorizontal: 0,
                controller: phoneController,
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              CustomSizedBox.space16H,
              CustomButton(
                marginHorizontal: 0,
                marginVertical: 0,
                label: 'Send code',
                onPressed: () async {
                  if (phoneController.text.isEmpty) {
                    showSnackBar(msg: 'Enter Phone Number First!');
                  } else {
                   await AuthController.to.forgetpassword(phoneController.text);
                  }
                  // Get.toNamed(OtpVerificationPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
