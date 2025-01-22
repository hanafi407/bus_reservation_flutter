import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/customer.dart';
import 'package:provider/provider.dart';

class ReservationExpantionsItem {
  final HeaderReservationExpation header;
  final BodyReservationExpantion body;
   bool isExpanded;

  ReservationExpantionsItem({required this.header, required this.body,  this.isExpanded=false});
}

class BodyReservationExpantion {
  final Customer customer;
  final int totalSeatBooked;
  final int totalPrice;
  final String seatNumber;

  BodyReservationExpantion({
    required this.customer,
    required this.totalSeatBooked,
    required this.totalPrice,
    required this.seatNumber,
  });
}

class HeaderReservationExpation {
  final int? reservationId;
  final String departureDate;
  final BusSchedule busSchedule;
  final int timeStamp;
  final String reservationStatus;

  HeaderReservationExpation(
      {required this.reservationId,
      required this.departureDate,
      required this.busSchedule,
      required this.timeStamp,
      required this.reservationStatus});
}
