import 'package:bus_reservation_udemy/datasource/data_source.dart';
import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/models/app_user.dart';
import 'package:bus_reservation_udemy/models/auth_response_model.dart';
import 'package:bus_reservation_udemy/models/bus_model.dart';
import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/bus_route.dart';
import 'package:bus_reservation_udemy/models/response_model.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';

class DummyDataSource extends DataSource {
  @override
  Future<ResponseModel> addBus(Bus bus) async {
    TempDB.tableBus.add(bus);
    return ResponseModel(
        responseStatus: ResponseStatus.SAVED,
        statusCode: 200,
        message: 'Add bus success',
        object: {});
  }

  @override
  Future<ResponseModel> addReservation(BusReservation reservation) async {
    TempDB.tableReservation.add(reservation);
    return ResponseModel(
        statusCode: 200,
        responseStatus: ResponseStatus.SAVED,
        message: "Reservation success saved",
        object: {});
  }

  @override
  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    TempDB.tableRoute.add(busRoute);
    return ResponseModel(
        responseStatus: ResponseStatus.SAVED,
        statusCode: 200,
        message: "Add route success",
        object: {});
  }

  @override
  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    TempDB.tableSchedule.add(busSchedule);
    return ResponseModel(
        responseStatus: ResponseStatus.SAVED,
        statusCode: 200,
        message: 'Add schedule success',
        object: {});
  }

  @override
  Future<List<Bus>> getAllBus() async {
    return TempDB.tableBus;
  }

  @override
  Future<List<BusReservation>> getAllReservation() async {
    return TempDB.tableReservation;
  }

  @override
  Future<List<BusRoute>> getAllRoutes() async {
    return TempDB.tableRoute;
  }

  @override
  Future<List<BusSchedule>> getAllSchedules() {
    // TODO: implement getAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    return TempDB.tableReservation.where((element) => element.customer.mobile == mobile).toList();
  }

  @override
  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    final reservationList = TempDB.tableReservation
        .where(
          (element) =>
              element.busSchedule.scheduleId == scheduleId &&
              element.departureDate == departureDate,
        )
        .toList();

    return reservationList;
  }

  @override
  Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom, String cityTo) async {
    try {
      BusRoute busRoute = TempDB.tableRoute
          .firstWhere((element) => element.cityFrom == cityFrom && element.cityTo == cityTo);
      return busRoute;
    } on StateError catch (error) {
      return null;
    }
  }

  @override
  Future<BusRoute?> getRouteByRouteName(String routeName) {
    // TODO: implement getRouteByRouteName
    throw UnimplementedError();
  }

  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return TempDB.tableSchedule
        .where((element) => element.busRoute.routeName == routeName)
        .toList();
  }

  @override
  Future<AuthResponseModel?> login(AppUser user) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
