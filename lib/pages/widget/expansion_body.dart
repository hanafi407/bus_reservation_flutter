import 'package:bus_reservation_udemy/models/reservation_expansions_item.dart';
import 'package:bus_reservation_udemy/pages/widget/row_custom.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpansionBody extends StatelessWidget {
  final BodyReservationExpantion body;
  const ExpansionBody({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 35,
        left: 35,
        bottom: 15,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detail',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          RowCustom(label: "Customer name", value: body.customer.customerName),
          // const SizedBox(height: 5),
          RowCustom(label: "Customer email", value: body.customer.email),
          // const SizedBox(height: 5),
          RowCustom(label: "Customer phone", value: body.customer.mobile),
          RowCustom(label: "Total seat", value: body.totalSeatBooked.toString()),
          RowCustom(label: "Seat number", value: body.seatNumber),
          RowCustom(
              label: "Total price",
              value: '$currency${NumberFormat('#,###').format(body.totalPrice)}'),
        ],
      ),
    );
  }
}
