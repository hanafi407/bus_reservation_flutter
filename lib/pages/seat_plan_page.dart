import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/pages/seat_plan_view.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatPlanPage extends StatefulWidget {
  const SeatPlanPage({super.key});

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  @override
  late BusSchedule schedule;
  late String departureDate;
  int totalSeatBooked = 0;
  String bookedSeatNumber = "";
  List<String> selectedSeat = [];
  bool isFirst = true;
  bool isDataLoading = true;
  ValueNotifier<String> selectedSeatStringNotifier = ValueNotifier("");

  _getData() async {
    List<BusReservation> reservation = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationsByScheduleAndDepartureDate(schedule.scheduleId!, departureDate);
    setState(() {
      isDataLoading = false;
    });
    List<String> seats = []; //['a1,a2,a3','b1',]
    for (final reser in reservation) {
      totalSeatBooked += reser.totalSeatBooked;
      seats.add(reser.seatNumbers);
    }
    bookedSeatNumber = seats.join(",");
  }

  @override
  void didChangeDependencies() {
    final myArgs = ModalRoute.of(context)?.settings.arguments as List;
    schedule = myArgs[0];
    departureDate = myArgs[1];
    _getData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seat Plan')),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          color: seatBookedColor,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text("Booked")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: seatAvailableColor,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text("Available"),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: selectedSeatStringNotifier,
                builder: (context, value, _) => Text(
                  "Selected: $value",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              if (!isDataLoading)
                Expanded(
                    child: SingleChildScrollView(
                  child: SeatPlanView(
                    totalSeatBooked: totalSeatBooked,
                    bookedSeatNumber: bookedSeatNumber,
                    busSchedule: schedule,
                    onSelectedSeat: (value, seat) {
                      if (value) {
                        selectedSeat.add(seat);
                      } else {
                        selectedSeat.remove(seat);
                      }
                      selectedSeatStringNotifier.value = selectedSeat.join(',');
                    },
                  ),
                )),
              ElevatedButton(
                onPressed: () {
                  if (selectedSeat.isEmpty) {
                    showMsg(context, "Please select seat");
                    return;
                  }
                  Navigator.pushNamed(
                    context,
                    routeNameBookingConfirmationPage,
                    arguments: [
                      departureDate,
                      schedule,
                      selectedSeat.length,
                      selectedSeatStringNotifier.value,
                    ],
                  );
                },
                child: const Text("Next"),
              ),
            ],
          )),
    );
  }
}
