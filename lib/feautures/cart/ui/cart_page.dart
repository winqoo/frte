import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshflow_test/app/navigation/page_navigation_keys.dart';
import 'package:freshflow_test/domain/cart_item.dart';
import 'package:freshflow_test/feautures/cart/data/cart_cubit.dart';
import 'package:freshflow_test/feautures/login/data/login_bloc.dart';
import 'package:freshflow_test/services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<CartCubit>(
        create: (context) => CartCubit(CartService())..fetchCart(),
        child: const CartPageContent(),
      );
}

class CartPageContent extends StatelessWidget {
  const CartPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<LoginCubit>(context).logOut();
                Navigator.of(context).pushReplacementNamed(
                  PageNavigationKeys.startRoute,
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<CartCubit, CartCubitState>(
        builder: (context, state) {
          if (state is CartCubitStateSet) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return _CartItemListTile(
                    cartItem: state.cartItems[index],
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          PageNavigationKeys.cartItemRoute,
                          arguments: state.cartItems[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.cartItems.length);
          } else if (state is CartCubitStateEmpty) {
            return const Center(
              child: Text('cart is empty'),
            );
          } else if (state is CartCubitStateError) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('an error occurred,try again'),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<CartCubit>(context).fetchCart();
                    },
                    child: Container(
                        color: theme.colorScheme.secondaryVariant,
                        child: const Text('retry')),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _CartItemListTile extends StatelessWidget {
  final Function()? onTap;
  final CartItem cartItem;

  const _CartItemListTile({Key? key, this.onTap, required this.cartItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.network(
        cartItem.url,
        width: 24,
        height: 24,
      ),
      title: Text(cartItem.name),
      trailing: Text('price ${cartItem.price}'),
    );
  }
}
