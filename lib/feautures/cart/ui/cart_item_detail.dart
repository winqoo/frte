import 'package:flutter/material.dart';
import 'package:freshflow_test/domain/cart_item.dart';

class CartItemDetails extends StatelessWidget {
  final CartItem cartItem;

  const CartItemDetails({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(
            cartItem.url,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(cartItem.name),
        ],
      ),
    );
  }
}
