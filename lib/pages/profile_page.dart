import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/controller/user_controller.dart';
import 'package:medi_source_apitest/pages/create_new_password_page.dart';
import 'package:medi_source_apitest/pages/profile/edit_profile_page.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName ='/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            AuthController.to.logout();
          }, icon: Icon(Icons.logout)), IconButton(onPressed: () {
            Get.toNamed(EditProfileScreen.routeName);
          }, icon: Icon(Icons.edit))
        ],
      ),
      body: Obx(
        () {
          return Column(
            children: [
             Text(UserController.to.userInfo.value.name??'') ,
             Text(UserController.to.userInfo.value.email??'') ,
             Text(UserController.to.userInfo.value.phone??'') ,
             Text(UserController.to.userInfo.value.address??'') ,
             Text(UserController.to.userInfo.value.district!.name??'') ,
             Text(UserController.to.userInfo.value.area!.name??'') ,
ElevatedButton(onPressed: () {
  Get.toNamed(CreateNewPasswordPage.routeName,arguments: 'logged in');
}, child: Text('Change password'))

            ],
          );
        }
      ),
    );
  }
}
