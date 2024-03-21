import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double subtotal =HomeController.to
        .cartList.map((e) => double.parse(e.product.price??'0')*int
        .parse(e.quantity.toString())).toList().reduce((value, element) =>
    value + element);
    double discount =HomeController.to
        .cartList.map((e) => double.parse(e.product
        .discountPrice??'0')*e.quantity
    ).toList().reduce((value, element) => value + element);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return ListView.builder(
              itemCount: HomeController.to.cartList.length,
              itemBuilder: (context, index) {
                final cart = HomeController.to.cartList[index];
                return ListTile(
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
            );
          })),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Row(
              children: [Text('Subtotal'), Spacer(), Text(subtotal
                  .toStringAsFixed(2)
              )
              ],
            ),
             Row(
              children: [Text('discount'), Spacer(), Text(discount
                  .toStringAsFixed(2))],
            ),
            Row(
              children: [
                 Text('total ${(subtotal-discount).toStringAsFixed(2)}'),
                const Spacer(),
                Expanded(
                  child: CustomButton(
                    marginVertical: 0,
                    label: 'Checkout',
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
