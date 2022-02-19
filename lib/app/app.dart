import 'package:flutter/material.dart';
import 'package:freshflow_test/app/resources/app_theme.dart';

import 'navigation/navigation_observer.dart';
import 'navigation/page_navigation_keys.dart';
import 'navigation/page_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glooko test',
      theme: AppTheme.createTheme(),
      onGenerateRoute: PageRouter().onGenerateRoute,
      initialRoute: PageNavigationKeys.startRoute,
      navigatorKey: PageNavigationKeys.navigatorKey,
      navigatorObservers: [
        NavigationRouteObserver(),
      ],
    );
  }
}
