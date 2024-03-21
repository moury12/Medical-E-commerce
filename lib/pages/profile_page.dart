import 'package:flutter/material.dart';
import 'package:medi_source_apitest/controller/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName ='/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
         Text(UserController.to.userInfo.value.name??'') ,
         Text(UserController.to.userInfo.value.email??'') ,
         Text(UserController.to.userInfo.value.phone??'') ,
         Text(UserController.to.userInfo.value.address??'') ,
         Text(UserController.to.userInfo.value.district!.name??'') ,
         Text(UserController.to.userInfo.value.area!.name??'') ,


        ],
      ),
    );
  }
}
