import 'package:bus_reservation_udemy/pages/add_bus_page.dart';
import 'package:bus_reservation_udemy/pages/add_route_page.dart';
import 'package:bus_reservation_udemy/pages/add_schedule_page.dart';
import 'package:bus_reservation_udemy/pages/booking_confirmation_page.dart';
import 'package:bus_reservation_udemy/pages/login_page.dart';
import 'package:bus_reservation_udemy/pages/not_found_page/not_found_page.dart';
import 'package:bus_reservation_udemy/pages/search_page.dart';
import 'package:bus_reservation_udemy/pages/search_result_page.dart';
import 'package:bus_reservation_udemy/pages/seat_plan_page.dart';
import 'package:bus_reservation_udemy/pages/view_reservation_page.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';

class RouteApp {
  final double width;
//  final RouteSettings settings;
  RouteApp({required this.width});

  Route<dynamic>? route(settings) {
    final Uri uri = Uri.parse(settings.name!);
    final String path = uri.path;
    print(path);
    switch (path) {
      case routeNameHome:
        return MaterialPageRoute(
            builder: (context) => SearchPage(
                  width: width,
                ));
      case routeNameSearchResultPage:
        return MaterialPageRoute(builder: (context) => const SearchResultPage());
      case routeNameSeatPlanPage:
        return MaterialPageRoute(builder: (context) => const SeatPlanPage());
      case routeNameBookingConfirmationPage:
        return MaterialPageRoute(builder: (context) => const BookingConfirmationPage());
      case routeNameAddBusPage:
        return MaterialPageRoute(builder: (context) {
          return const AddBusPage();
        });
      case routeNameAddSchedulePage:
        return MaterialPageRoute(builder: (context) => const AddSchedulePage());
      case routeNameAddRoutePage:
        return MaterialPageRoute(builder: (context) => const AddRoutePage());
      case routeNameReservationPage:
        return MaterialPageRoute(builder: (context) => const ViewReservationPage());
      case routeNameLoginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (context) => NotFoundPage());
    }
  }
}
