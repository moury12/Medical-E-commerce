import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';

class CartScreen extends StatelessWidget {
  static const String routeName ='/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
Expanded(child: ListView.builder(
  itemCount: HomeController.to.cartList.length,
  itemBuilder: (context, index) {
  final cart = HomeController.to.cartList[index];
  return ListTile(
    trailing: IconButton(onPressed: () {
      HomeController.to.removeFromCart(cart.id);
    },
      icon: Icon(Icons.delete),
    ),
    title: Text(cart.product.name??''),
    subtitle: Row(
      children: [
        IconButton(onPressed: () {
          HomeController.to
              .updateCart(cart.id, cart.quantity + 1);
        },
          icon: Icon(Icons.add),
        ),
        Text('Quantity ${cart.quantity}'),
        IconButton(onPressed: () {
          if (cart.quantity > 1) {
            HomeController.to
                .updateCart(cart.id, cart.quantity - 1);
          } else {
            HomeController.to.removeFromCart(cart.id);
          }
        },
          icon: Icon(Icons.minimize),
        ),
      ],
    ),
    leading: CustomNetworkImage(networkImagePath: cart.product.image??''),
  );
},))
      ],),
    );
  }
}
