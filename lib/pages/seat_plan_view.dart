import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';

class SeatPlanView extends StatelessWidget {
  final int totalSeatBooked;
  final String bookedSeatNumber;
  final BusSchedule busSchedule;
  final Function(bool, String) onSelectedSeat;
  const SeatPlanView({
    super.key,
    required this.totalSeatBooked,
    required this.bookedSeatNumber,
    required this.busSchedule,
    required this.onSelectedSeat,
  });

  @override
  Widget build(BuildContext context) {
    bool isBussiness = busSchedule.bus.busType == busTypeACBusiness;
    int rowSeat = isBussiness ? 3 : 4;
    int columnSeat = busSchedule.bus.totalSeat ~/ rowSeat;
    List<List<String>> seatArrangement = [];
    List<String> bookedSeatList = bookedSeatNumber.isEmpty ? [] : bookedSeatNumber.split(',');

    for (var i = 0; i < columnSeat; i++) {
      List<String> column = [];
      for (var j = 0; j < rowSeat; j++) {
        column.add("${seatLabelList[i]}${j + 1}");
      }
      seatArrangement.add(column);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Text(
            "FRONT",
            style: TextStyle(fontSize: 30),
          ),
          const Divider(
            height: 5,
            color: Colors.black,
          ),
          for (var i = 0; i < seatArrangement.length; i++)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var j = 0; j < seatArrangement[i].length; j++)
                      Row(
                        children: [
                          Seat(
                            label: seatArrangement[i][j],
                            onSelect: (value) {
                              onSelectedSeat(value, seatArrangement[i][j]);
                            },
                            isBooked: bookedSeatList.contains(seatArrangement[i][j]),
                          ),
                          if (j == 0 && isBussiness)
                            const SizedBox(
                              width: 40,
                              height: 40,
                            ),
                          if (j == 1 && !isBussiness)
                            const SizedBox(
                              width: 40,
                              height: 40,
                            )
                        ],
                      ),
                  ],
                ))
        ],
      ),
    );
  }
}

class Seat extends StatefulWidget {
  final String label;
  final bool isBooked;
  final Function(bool) onSelect;
  const Seat({
    super.key,
    required this.label,
    required this.onSelect,
    required this.isBooked,
  });

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    String label = widget.label;
    final select = widget.onSelect;
    return InkWell(
      onTap: widget.isBooked
          ? null
          : () {
              setState(() {
                isSelected = !isSelected;
              });
              select(isSelected);
            },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? Colors.green
                : widget.isBooked
                    ? Colors.red
                    : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 5,
                spreadRadius: 2,
              )
            ]),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: widget.isBooked || isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
