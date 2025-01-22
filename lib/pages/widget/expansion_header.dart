import 'package:bus_reservation_udemy/models/reservation_expansions_item.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpansionHeader extends StatelessWidget {
  final HeaderReservationExpation header;

  const ExpansionHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text('${header.departureDate} ${header.busSchedule.departureTime}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${header.busSchedule.busRoute.routeName} ${header.busSchedule.bus.busType}'),
            Text(
              'Booking time: ${myFormatDate(DateTime.fromMillisecondsSinceEpoch(header.timeStamp), format: 'EEE, dd MMM yyyy HH:mm')}',
            ),
          ],
        ),
      ),
    );
  }
}
