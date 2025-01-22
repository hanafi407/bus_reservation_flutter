import 'package:bus_reservation_udemy/my_route_observer.dart';
import 'package:bus_reservation_udemy/pages/add_bus_page.dart';
import 'package:bus_reservation_udemy/pages/add_route_page.dart';
import 'package:bus_reservation_udemy/pages/add_schedule_page.dart';
import 'package:bus_reservation_udemy/pages/booking_confirmation_page.dart';
import 'package:bus_reservation_udemy/pages/login_page.dart';
import 'package:bus_reservation_udemy/pages/search_page.dart';
import 'package:bus_reservation_udemy/pages/search_result_page.dart';
import 'package:bus_reservation_udemy/pages/seat_plan_page.dart';
import 'package:bus_reservation_udemy/pages/view_reservation_page.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/route_app.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => AppDataProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  late double width;
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    RouteApp routeApp = RouteApp(width: width);
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              height: 1.5,
            ),
          ),
          scaffoldBackgroundColor: Colors.grey.shade200,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
          ),
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: Colors.black,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            foregroundColor: Colors.white,
          )),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: routeNameHome,
      // onGenerateRoute: routeApp.route,
      // navigatorObservers: [MyRouteObserver()],
      routes: {
        routeNameLoginPage: (context) => const LoginPage(),
        routeNameHome: (context) => SearchPage(
              width: width,
            ),
        routeNameSearchResultPage: (context) => const SearchResultPage(),
        routeNameSeatPlanPage: (context) => const SeatPlanPage(),
        routeNameBookingConfirmationPage: (context) => const BookingConfirmationPage(),
        routeNameAddBusPage: (context) => const AddBusPage(),
        routeNameAddRoutePage: (context) => const AddRoutePage(),
        routeNameAddSchedulePage: (context) => const AddSchedulePage(),
        routeNameReservationPage: (context) => const ViewReservationPage(),
      },
    );
  }
}
