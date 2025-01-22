import 'package:bus_reservation_udemy/pages/add_bus_page.dart';
import 'package:flutter/material.dart';

class MyRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is MaterialPageRoute) {
      handleDeepLink(route.settings.name);
      print(route.settings.name);
    }
  }

  void handleDeepLink(String? route) {
    if (route != null) {
      final Uri uri = Uri.parse(route);
      final String path = uri.path;

      switch (path) {
        case '/add-bus':
          // Navigate to AddBusPage programmatically
          navigator?.push(MaterialPageRoute(builder: (context) => AddBusPage()));
          break;
        // Add more cases as needed
      }
    }
  }
}
