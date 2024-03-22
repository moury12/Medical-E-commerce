import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';

class OrderListScreen extends StatelessWidget {
  static const String routeName = '/order';
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          return ListView.builder(
            controller: HomeController.to.scrollForOrder,
            itemCount: HomeController.to.orderList.length,
            itemBuilder: (context, index) {
              final order = HomeController.to.orderList[index];
              return HomeController.to.orderList.isEmpty?const CircularProgressIndicator(): ListTile(
                title: Text(order.orderId ?? ''),
                subtitle: Text(order.total ?? ''),
              );
            },
          );
        }
      ),
    );
  }
}
