import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/customer.dart';
import 'package:bus_reservation_udemy/pages/widget/text_field_custom.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({super.key});

  @override
  State<BookingConfirmationPage> createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  final _formKeyConfirm = GlobalKey<FormState>();
  final _focusNodeName = FocusNode();
  final _focusNodeEmail = FocusNode();
  final _focusNodePhone = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late String departureDate;
  late BusSchedule schedule;
  late int totalSeat;
  late String seatNumber;

  int totalPrice() {
    int totalWithoutDiscount = (schedule.ticketPrice * totalSeat);
    int discount = ((schedule.discountPercent / 100) * totalWithoutDiscount).toInt();
    return (totalWithoutDiscount - discount) + schedule.processingFee;
  }

  void _onConfirm() {
    if (_formKeyConfirm.currentState!.validate()) {
      Customer customer = Customer(
          customerName: nameController.text,
          email: emailController.text,
          mobile: phoneController.text);

      BusReservation busReservation = BusReservation(
        busSchedule: schedule,
        customer: customer,
        departureDate: departureDate,
        reservationStatus: reservationActive,
        seatNumbers: seatNumber,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        totalPrice: totalPrice(),
        totalSeatBooked: totalSeat,
      );

      Provider.of<AppDataProvider>(context, listen: false)
          .addReservation(busReservation)
          .then((value) {
        if (value.statusCode == 200) {
          Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
        } else {
          showMsg(context, value.message);
        }
      }).catchError((err) {
        showMsg(context, "Can not save");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = 'hanafi';
    emailController.text = 'hanafi@gmail.com';
    phoneController.text = '0000';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as List;
    departureDate = args[0];
    schedule = args[1];
    totalSeat = args[2];
    seatNumber = args[3];
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodeName.dispose();
    _focusNodePhone.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKeyConfirm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    const Text(
                      "Please provide your information:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [
                        TextFieldCustom(
                          focusNode: _focusNodeName,
                          controller: nameController,
                          prefixIcon: Icons.account_circle_sharp,
                          hint: "name",
                          onChanged: (value) {
                            setState(() {
                              nameController.text = value;
                            });
                          },
                          textInputType: TextInputType.text,
                        ),
                        TextFieldCustom(
                          focusNode: _focusNodeEmail,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_sharp,
                          hint: "email",
                          onChanged: (value) {
                            setState(() {
                              emailController.text = value;
                            });
                          },
                        ),
                        TextFieldCustom(
                          focusNode: _focusNodePhone,
                          textInputType: TextInputType.phone,
                          controller: phoneController,
                          prefixIcon: Icons.phone_android_rounded,
                          hint: "phone",
                          onChanged: (value) {
                            setState(() {
                              phoneController.text = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Booking details:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    DetailContent(
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      schedule: schedule,
                      departureDate: departureDate,
                      seatNumber: seatNumber,
                      totalSeat: totalSeat,
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total price: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " $currency${NumberFormat('#,###').format(totalPrice())}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: _onConfirm,
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.schedule,
    required this.departureDate,
    required this.seatNumber,
    required this.totalSeat,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final BusSchedule schedule;
  final String departureDate;
  final String seatNumber;
  final int totalSeat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Name: "),
              Text(nameController.text),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Email: "),
              Text(emailController.text),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Phone: "),
              Text(phoneController.text),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Route: "),
              Text("${schedule.busRoute.cityFrom}-${schedule.busRoute.cityTo}"),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Departure date: "),
              Text(departureDate),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Departure time: "),
              Text(schedule.departureTime),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Seat Number: "),
              Text(seatNumber),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Seat: "),
              Text('$totalSeat'),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Price: "),
              Text(NumberFormat('#,###').format(schedule.ticketPrice)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Processing fee: "),
              Text(" ${NumberFormat('#,###').format(schedule.processingFee)}"),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Discount: "),
              Text(" ${NumberFormat('#,###').format(schedule.discountPercent)}%"),
            ],
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}
