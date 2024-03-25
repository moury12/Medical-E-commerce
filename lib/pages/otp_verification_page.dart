import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/otpContainer.dart';
import 'package:medi_source_apitest/pages/forgot_password_page.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:medi_source_apitest/theme_data.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/widgets/button/custom_button.dart';


class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});
  static const String routeName = '/otp_ver_page';

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late FocusNode text1, text2, text3, text4, text5, text6;

  final TextEditingController firstOtpController = TextEditingController();
  final TextEditingController secondOtpController = TextEditingController();
  final TextEditingController thirdOtpController = TextEditingController();
  final TextEditingController forthOtpController = TextEditingController();
  final TextEditingController fifthOtpController = TextEditingController();
  final TextEditingController sixthOtpController = TextEditingController();
  final previousRoute = Get.previousRoute;
  @override
  void initState() {
    text1 = FocusNode();
    text2 = FocusNode();
    text3 = FocusNode();
    text4 = FocusNode();
    text5 = FocusNode();
    text6 = FocusNode();
    text1.requestFocus();
    globalLogger.d(Get.previousRoute);
    super.initState();
  }

  @override
  void dispose() {
    firstOtpController.dispose();
    secondOtpController.dispose();
    thirdOtpController.dispose();
    forthOtpController.dispose();
    fifthOtpController.dispose();
    sixthOtpController.dispose();
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

              const Text(
                'Enter OTP',
                style: AppTheme.textStyleSemiBoldPrimary24,
              ),
              const Text('A 6 digit code has been sent to your email'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OtpContainer(
                        controller: firstOtpController,
                        focusNode: text1,
                      ),
                      const Spacer(),
                      OtpContainer(
                        controller: secondOtpController,
                        focusNode: text2,
                      ),
                      const Spacer(),
                      OtpContainer(
                        controller: thirdOtpController,
                        focusNode: text3,
                      ),
                      const Spacer(),
                      OtpContainer(
                        controller: forthOtpController,
                        focusNode: text4,
                      ),
                      const Spacer(),
                      OtpContainer(
                        controller: fifthOtpController,
                        focusNode: text5,
                      ),
                      const Spacer(),
                      OtpContainer(
                        controller: sixthOtpController,
                        focusNode: text6,
                      ),
                    ],
                  ),
                ),
              ),
              // const Center(
              //     child: Text(
              //   '02.32',
              //   style: TextStyle(color: AppColors.kPrimaryColor),
              // )),
              CustomButton(
                marginHorizontal: 0,
                label: 'Verify',
                onPressed: () {
                  print('object');
                  if (firstOtpController.text.isNotEmpty &&
                      secondOtpController.text.isNotEmpty &&
                      thirdOtpController.text.isNotEmpty &&
                      forthOtpController.text.isNotEmpty &&
                      fifthOtpController.text.isNotEmpty &&
                      sixthOtpController.text.isNotEmpty){
                    AuthController.to.otp(firstOtpController.text+secondOtpController.text+thirdOtpController.text+forthOtpController.text+fifthOtpController.text+sixthOtpController.text);
if (AuthController.to.isChangePassword.isTrue){
  AuthController.to.registerOtpVerification();

}else{
    AuthController.to.isChangePassword.value=false;
  AuthController.to.registerOtpVerification();

}
                  }else{
                    showSnackBar(msg: 'field required');
                  }
                },
              ),
              Center(
                child: TextButton(
                  child: Text('Resend OTP'),
                  onPressed: () async {
                    AuthController.to.forgetPassword(AuthController.to.registerPhone.value,true);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
