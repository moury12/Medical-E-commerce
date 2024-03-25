import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/constant/colorConstant.dart';
import 'package:medi_source_apitest/controller/AuthController.dart';
import 'package:medi_source_apitest/controller/user_controller.dart';
import 'package:medi_source_apitest/pages/login_page.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/dropdown/custom_dropdown.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = "/editProfile";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController(text:
  UserController.to.userInfo.value.name);
  TextEditingController emailController = TextEditingController(text:
  UserController.to.userInfo.value.email);
  TextEditingController phoneController = TextEditingController(text:
  UserController.to.userInfo.value.phone);
  TextEditingController addressController = TextEditingController(text:
  UserController.to.userInfo.value.address);

  bool isSelected = false;

  String selectedDistrict=UserController.to.userInfo.value.districtId??'';
  String selectedArea=UserController.to.userInfo.value.areaId??'';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();

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
            CustomButton(
              marginHorizontal: 0,
              marginVertical: 0,
              label: 'update',
              onPressed: () {
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty &&
                        phoneController.text.isEmpty ||
                    selectedDistrict == null ||
                    selectedArea == null ||
                    addressController.text.isEmpty) {
                  showSnackBar(msg: 'All Fields are required!');
                } else {
                  final body = {
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'district_id': selectedDistrict!,
                    'area_id': selectedArea!,
                    'address': addressController.text
                  };
                  UserController.to.updateUserProfileCall(body);
                }
              },
            ),
          ],
        ));
  }
}
