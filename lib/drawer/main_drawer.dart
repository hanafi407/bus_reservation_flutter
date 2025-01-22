import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  int initIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.directions_bus,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Bus App",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  )
                ]),
          ),
          drawerItem("Add Bus", Icons.bus_alert, 0, routeNameAddBusPage),
          drawerItem("Add Route", Icons.route, 1, routeNameAddRoutePage),
          drawerItem("Add Schedule", Icons.schedule, 2, routeNameAddSchedulePage),
          drawerItem("View Reservation", Icons.event, 3, routeNameReservationPage),
          drawerItem("Admin Login", Icons.login, 4, routeNameLoginPage),
        ],
      ),
    );
  }

  ListTile drawerItem(String title, IconData prefixIcon, int index, String routeName) {
    bool isSelected = initIndex == index;
    return ListTile(
      onTap: () {
        setState(() {
          initIndex = index;
        });
        Navigator.pushNamed(context, routeName);
      },
      leading: Icon(
        prefixIcon,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: const TextStyle(
            // color: isSelected ? Colors.black : Colors.grey,
            ),
      ),
    );
  }
}
