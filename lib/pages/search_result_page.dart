import 'package:bus_reservation_udemy/drawer/main_drawer.dart';
import 'package:bus_reservation_udemy/models/bus_route.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resultArgs = ModalRoute.of(context)?.settings.arguments as List;
    final BusRoute busRoute = resultArgs[0];
    final String departureDate = resultArgs[1];
    final provider = Provider.of<AppDataProvider>(context);
    provider.getSchedulesByRouteName(busRoute.routeName);
    return Scaffold(
      appBar: AppBar(title: const Text("Search Result")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text.rich(TextSpan(text: "Showing result from ", children: [
                TextSpan(
                  text: busRoute.cityFrom,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: " to ",
                ),
                TextSpan(
                  text: busRoute.cityTo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: " for ",
                ),
                TextSpan(
                  text: departureDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])),
              Consumer<AppDataProvider>(
                builder: (context, provider, _) {
                  return FutureBuilder<List<BusSchedule>>(
                      future: provider.getSchedulesByRouteName(busRoute.routeName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<BusSchedule> getScheduleRoute = snapshot.data!;
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: getScheduleRoute
                                  .map(
                                    (schedule) => CardItemScheduleView(
                                      schedule: schedule,
                                      date: departureDate,
                                    ),
                                  )
                                  .toList());
                        }
                        if (snapshot.hasError) {
                          return const Text("Schedule failed fetch");
                        }

                        return const Text("Please wait...");
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardItemScheduleView extends StatelessWidget {
  final BusSchedule schedule;
  final String date;
  const CardItemScheduleView({
    super.key,
    required this.schedule,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeNameSeatPlanPage, arguments: [schedule, date]);
      },
      borderRadius: BorderRadius.circular(13),
      child: Card(
        elevation: 5,
        child: Column(children: [
          ListTile(
            title: Text(schedule.bus.busName),
            subtitle: Text(schedule.bus.busType),
            trailing: Text(
              "$currency${schedule.ticketPrice}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              right: 20,
              left: 20,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("From: ${schedule.busRoute.cityFrom}"),
                    Text("To: ${schedule.busRoute.cityTo}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Departure Time: ${schedule.departureTime}"),
                    Text("Total Seat: ${schedule.bus.totalSeat}"),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
