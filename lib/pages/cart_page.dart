import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/controller/user_controller.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double subtotal =HomeController.to.cartList.isEmpty?0.00: HomeController.to
        .cartList
        .map((e) =>
            double.parse(e.product.price ?? '0') *
            int.parse(e.quantity.toString()))
        .toList()
        .reduce((value, element) => value + element);
    double discount =HomeController.to.cartList.isEmpty?0.00: HomeController.to.cartList
        .map((e) => double.parse(e.product.discountPrice ?? '0') * e.quantity)
        .toList()
        .reduce((value, element) => value + element);
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
       () {
          return Column(
            children: [
              Expanded(child: ListView.builder(
                  itemCount: HomeController.to.cartList.length,
                  itemBuilder: (context, index) {
                    final cart = HomeController.to.cartList[index];
                    return HomeController.to.cartList.isEmpty?Text('cart is empty'):ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          HomeController.to.removeFromCart(cart.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      title: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(cart.product.name ?? ''),
                            Text(cart.product.price ?? ''),
                          ],
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              HomeController.to
                                  .updateCart(cart.id, cart.quantity + 1);
                            },
                            icon: const Icon(Icons.add),
                          ),
                          Text('Quantity ${cart.quantity}'),
                          IconButton(
                            onPressed: () {
                              if (cart.quantity > 1) {
                                HomeController.to
                                    .updateCart(cart.id, cart.quantity - 1);
                              } else {
                                HomeController.to.removeFromCart(cart.id);
                              }
                            },
                            icon: const Icon(Icons.minimize),
                          ),
                        ],
                      ),
                      leading: CustomNetworkImage(
                          networkImagePath: cart.product.image ?? ''),
                    );
                  },
                )
              ),
            ],
          );
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
           () {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text('Subtotal'),
                    const Spacer(),
                    Text(subtotal
                        .toStringAsFixed(2))
                  ],
                ),
                Row(
                  children: [
                    const Text('discount'),
                    const Spacer(),
                    Text(discount.toStringAsFixed(2))
                  ],
                ),
                Row(
                  children: [
                    Text('total ${(subtotal - discount).toStringAsFixed(2)}'),
                    const Spacer(),
                    Expanded(
                      child: CustomButton(
                        marginVertical: 0,
                        label: 'Checkout',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: const Text('Are you sure to order?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      checkoutCall(subtotal, discount);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No')),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  void checkoutCall(double subtotal, double discount) async {
    final now = DateTime.now();
    final item = [];
    for (var e in HomeController.to.cartList) {
      final itemInfo = {
        "product_id": e.product.id.toString()??'',
        "name": e.product.name??'',
        "qty": e.quantity.toString()??'',
        "rate": e.product.price.toString()??'',
        "discount_amount": e.product.discountPrice.toString()??'',
        "discount_percentage": e.product.discountPercentage.toString()??'',
        "net_amount": (subtotal - discount).toStringAsFixed(2)
      };
      item.add(itemInfo);
    }
    final data = {
      'user_name': UserController.to.userInfo.value.name??'',
      'user_phone': UserController.to.userInfo.value.phone.toString()??'',
      'area_id': UserController.to.userInfo.value.areaId.toString()??'',
      'subtotal': subtotal.toString(),
      'discount': discount.toString(),
      'total': (subtotal - discount).toStringAsFixed(2),
      'delivery_date': DateFormat('yyyy-MM-dd').format(now.add(Duration(days: 1))).toString()??'',
      'order_details': jsonEncode(item)??''

    };
    globalLogger.d(data);
    await HomeController.to.checkoutCall(data);
  }
}
