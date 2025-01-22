const String currency = 'Rp.';
const String busTypeNonAc = 'NON-AC';
const String busTypeACEconomy = 'AC-ECONOMY';
const String busTypeACBusiness = 'AC-BUSINESS';
const String reservationConfirmed = 'Confirmed';
const String reservationCancelled = 'Cancelled';
const String reservationActive = 'Active';
const String reservationExpired = 'Expired';
const String emptyFieldErrMessage = 'This field must not be empty';
const String emptyDateErrMessage = 'The Date must not be empty';
const String accessToken = 'accessToken';
const String loginTime = 'loginTime';
const String expirationDuration = 'expirationDuration';
const String routeNameHome = '/';
const String routeNameSearchResultPage = '/search-result';
const String routeNameLoginPage = '/login';
const String routeNameSeatPlanPage = '/seat-plan';
const String routeNameBookingConfirmationPage = '/booking-confirmation';
const String routeNameAddBusPage = '/add-bus';
const String routeNameAddRoutePage = '/add-route';
const String routeNameAddSchedulePage = '/add-schedule';
const String routeNameScheduleListPage = '/schedule-list';
const String routeNameReservationPage = '/reservation';

const cities = [
  'Tegal',
  'Jakarta',
  'Cikarang',
  'Karawang',
  'Brebes',
  'Pemalang',
  'Pekalongan',
];

enum ResponseStatus {
  SAVED,
  FAILED,
  UNAUTHORIZED,
  AUTHORIZED,
  EXPIRED,
  NONE,
}

List<String> busTypes = [busTypeACBusiness, busTypeACEconomy, busTypeNonAc];

const seatLabelList = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
