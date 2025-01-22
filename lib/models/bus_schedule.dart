import 'bus_model.dart';
import 'bus_route.dart';

class BusSchedule {
  int? scheduleId;
  Bus bus;
  BusRoute busRoute;
  String departureTime;
  int ticketPrice;
  int discountPercent;
  int processingFee;

  BusSchedule(
      {this.scheduleId,
      required this.bus,
      required this.busRoute,
      required this.departureTime,
      required this.ticketPrice,
      this.discountPercent = 10,
      this.processingFee = 2000});
}
