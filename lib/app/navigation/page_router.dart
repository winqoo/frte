import 'package:flutter/material.dart';
import 'package:freshflow_test/app/navigation/page_navigation_keys.dart';
import 'package:freshflow_test/app/navigation/pages_routes.dart';
import 'package:freshflow_test/domain/cart_item.dart';
import 'package:freshflow_test/feautures/cart/ui/cart_item_detail.dart';
import 'package:freshflow_test/feautures/cart/ui/cart_page.dart';
import 'package:freshflow_test/feautures/login/ui/login_page.dart';

class PageRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageNavigationKeys.startRoute:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case PageNavigationKeys.cartRoute:
        return PageRoutes.fade(() => const CartPage(), milliseconds: 900);
      case PageNavigationKeys.cartItemRoute:
        return PageRoutes.fade(
            () => CartItemDetails(
                  cartItem: settings.arguments as CartItem,
                ),
            milliseconds: 900);
      default:
        return null;
    }
  }
}
