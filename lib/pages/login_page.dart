import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/constant/colorConstant.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/pages/forgot_password_page.dart';
import 'package:medi_source_apitest/pages/registration_screen.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool rememberCheck = false;
  String? errorEmail;
  String? errorPassword;

  int previousPos = -1;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),

              CustomContainer(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                height: size.height -
                    (size.height * 0.04 +
                        MediaQuery.of(context).viewPadding.top +
                        12 +
                        size.height * 0.22),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Login',
                        ),
                      ),
                      CustomTextField(
                        enableBorderColor:
                        AppColors.kPrimaryColor.withOpacity(.8),
                        borderWidth: .8,
                        focusColor: AppColors.kPrimaryColor.withOpacity(.8),
                        height: 48,
                        marginVertical: 0,
                        marginHorizontal: 0,
                        controller: phoneController,
                        labelText: 'Phone Number',
                        labelSize: 16,
                        hintText: 'Enter your email address',
                        onChanged: (val) {
                        },
                      ),
                      CustomTextField(
                        enableBorderColor:
                        AppColors.kPrimaryColor.withOpacity(.8),
                        borderWidth: .8,
                        focusColor: AppColors.kPrimaryColor.withOpacity(.8),
                        height: 48,
                        marginVertical: 0,
                        marginHorizontal: 0,
                        controller: passwordController,
                        // hasHeaderTitle: true,
                        obscureText: true,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        isPassword: true,
                        suffixIconColor: AppColors.kPrimaryColor,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 2),
                          Transform.scale(
                            scale: .8,
                            child: Checkbox(
                              activeColor: Colors.black,
                              checkColor: Colors.white,
                              value: rememberCheck,
                              onChanged: (value) {
                                setState(() {
                                  rememberCheck = value!;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: const Color(0xff000000).withOpacity(.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(ForgotPasswordPage.routeName);
                                },
                                child:  Text('Forgot Password?'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      CustomButton(
                        marginHorizontal: 0,
                        marginVertical: 0,
                        label: 'Login',
                        onPressed: () {
AuthController.to.loginRequest(phoneController.text, passwordController.text);
AuthController.to.isChangePassword.value=false;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                        TextButton(
                            child: Text('Signup'),
                            onPressed: () {
                              Get.toNamed(SignupScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
        this.child,
        this.height,
        this.width,
        this.padding,
        this.borderRadius,
        this.backgroundColor,
        this.gradient,
        this.boxShadow,
        this.borderWidth,
        this.borderColor});
  final Widget? child;
  final double? height, width, borderWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor, borderColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: const Offset(5, 0))
            ],
        gradient: gradient,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
      ),
      child: child,
    );
  }
}
