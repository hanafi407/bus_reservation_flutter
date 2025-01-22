import 'package:bus_reservation_udemy/datasource/app_data_source.dart';
import 'package:bus_reservation_udemy/datasource/data_source.dart';
import 'package:bus_reservation_udemy/datasource/dummy_data_source.dart';
import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/models/app_user.dart';
import 'package:bus_reservation_udemy/models/auth_response_model.dart';
import 'package:bus_reservation_udemy/models/bus_model.dart';
import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/bus_route.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/reservation_expansions_item.dart';
import 'package:bus_reservation_udemy/models/response_model.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier {
  final List<BusSchedule> _scheduleRoute = [];
  List<Bus> _busList = [];
  List<BusRoute> _routeList = [];
  List<BusReservation> _busReservation = [];

  List<BusSchedule> get getScheduleRoute => _scheduleRoute;
  List<Bus> get busList => _busList;
  List<BusRoute> get routeList => _routeList;
  List<BusReservation> get busReservation => _busReservation;

  final DataSource _dataSource = AppDataSource();

  Future<AuthResponseModel?> login(AppUser user) async {
    final response = await _dataSource.login(user);
    if (response == null) return null;
    await saveToken(response.accessToken);
    await saveExpirationDuration(response.expirationDuration);
    await saveLoginTime(response.logInTime);

    return response;
  }

  Future<ResponseModel> addBus(Bus bus) {
    return _dataSource.addBus(bus);
  }

  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    return _dataSource.addRoute(busRoute);
  }

  Future<ResponseModel> addSchedule(BusSchedule busSchedule) async {
    return _dataSource.addSchedule(busSchedule);
  }

  Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom, String cityTo) async {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return await _dataSource.getSchedulesByRouteName(routeName);
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    final reservation =
        await _dataSource.getReservationsByScheduleAndDepartureDate(scheduleId, departureDate);

    return reservation;
  }

  Future<ResponseModel> addReservation(BusReservation busReservation) async {
    return _dataSource.addReservation(busReservation);
  }

  void getAllBus() async {
    _busList = await _dataSource.getAllBus();
    notifyListeners();
  }

  void getAllRoutes() async {
    _routeList = await _dataSource.getAllRoutes();
    notifyListeners();
  }

  Future<List<BusReservation>> getAllReservation() async {
    _busReservation = await _dataSource.getAllReservation();
    notifyListeners();
    return _busReservation;
  }

  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    List<BusReservation> reservation = await _dataSource.getReservationsByMobile(mobile);
    return reservation;
  }

  List<ReservationExpantionsItem> getExpansionitem(List<BusReservation> busReservation) {
    return List.generate(busReservation.length, (index) {
      final reservation = busReservation[index];
      return ReservationExpantionsItem(
        header: HeaderReservationExpation(
          reservationId: reservation.reservationId,
          departureDate: reservation.departureDate,
          busSchedule: reservation.busSchedule,
          timeStamp: reservation.timestamp,
          reservationStatus: reservation.reservationStatus,
        ),
        body: BodyReservationExpantion(
          customer: reservation.customer,
          totalSeatBooked: reservation.totalSeatBooked,
          totalPrice: reservation.totalPrice,
          seatNumber: reservation.seatNumbers,
        ),
      );
    });
  }
}
