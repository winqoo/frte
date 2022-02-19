
import 'package:flutter/material.dart';
import 'package:freshflow_test/app/navigation/page_navigation_keys.dart';
import 'package:freshflow_test/app/navigation/pages_routes.dart';



class PageRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageNavigationKeys.startRoute:
        return MaterialPageRoute(builder: (context) => Container());
      case PageNavigationKeys.ageRoute:
        return PageRoutes.fade(() => Container(), milliseconds: 900);
      default:
        return null;
    }
  }
}

