import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/constant/global.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/pages/search_page.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

class HomePage extends StatefulWidget {
  static const String routeName='/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      drawer: Drawer(
          child: Column(children: [
        Expanded(child: ListView.builder(
          itemCount:HomeController.to.companyList.length ,
          itemBuilder: (context, index) {
          final company =HomeController.to.companyList[index];
          return CheckboxListTile(
            title: Text(company.name??''),
            value: company.userCheck, onChanged:
          (value) {
company.userCheck=value;
setState(() {

});
          },);
        },))
      ],)),
      appBar:
      AppBar(backgroundColor: Colors.white,elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(icon: Icon(Icons.menu),onPressed: () {
            Scaffold.of(context).openDrawer();
          },);
        }
      ),),
      body: Column(children: [
        Obx(
           () {
            return Row(children: List.generate(HomeController.to.sliderList.length, (index) {
              final slider = HomeController.to.sliderList[index];
              return CustomNetworkImage(networkImagePath: slider.image??'',borderRadius: 0,height: 200,);
            }),);
          }
        ),GestureDetector(
          onTap: () {
            Get.toNamed(SearchScreen.routeName);
          },
          child: CustomTextField(hintText: 'Search Product',
          ),
        ),
        Obx(
      () {
            return Row(children: [...List.generate(HomeController.to.categoryList.length, (index) => Text(HomeController.to.categoryList[index].name,style: TextStyle(color: Colors.black),))],);
          }
        ),
       SizedBox(height: 300,
         child: GridView.builder(
itemCount:HomeController.to.productList.value.length ,
           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200), itemBuilder: (context, index) {
          final product=HomeController.to.productList.value[index];
           return CustomNetworkImage( networkImagePath:
           product.image??'',) ;
         },),
       )
       /* Obx(() => HomeController.to.homeProductLoading.value?CircularProgressIndicator():HomeController.to.productList.isEmpty?Center(child: Text('there is no product'),):GridView.builder( itemCount:HomeController.to.productList.length ,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 210, maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
          final product= HomeController.to.productList[index];
          return Container(child: Column(children: [Text(product.name??'')],),);
        },))*/

      ],),
    );
  }
}
