

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshflow_test/domain/cart_item.dart';

abstract class BaseCartService {
  Future<List<CartItem>> getAllCartItems();

}

class CartService  implements BaseCartService{
  final cartRef = FirebaseFirestore.instance.collection('items');


  @override
  Future<List<CartItem>> getAllCartItems() async {
    var snapshot = await cartRef.get();
    var data = snapshot.docs.map((s) => s.data());
    var cartItems = data.map((d) => CartItem.fromJson(d));
    return cartItems.toList();
  }


}
