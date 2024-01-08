import 'package:flutter/material.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';

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
      appBar:
AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: Column(children: [
        Row(children: List.generate(HomeController.to.sliderList.length, (index) {
          final slider = HomeController.to.sliderList[index];
          return CustomNetworkImage(networkImagePath: slider.image??'',borderRadius: 0,);
        }),),
        

      ],),
    );
  }
}
