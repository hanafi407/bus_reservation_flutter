import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/models/bus_model.dart';
import 'package:bus_reservation_udemy/models/bus_route.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/pages/widget/drop_down_custom.dart';
import 'package:bus_reservation_udemy/pages/widget/text_field_custom.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  Bus? bus;
  BusRoute? busRoute;
  TimeOfDay? departureTime;

  final _formKeySchedule = GlobalKey<FormState>();
  final _focusNodeTicketPrice = FocusNode();
  final _focusNodeDiscount = FocusNode();
  final _focusNodeProcessingFee = FocusNode();

  TextEditingController ticketPriceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController processingFeeController = TextEditingController();

  void getData() {
    Provider.of<AppDataProvider>(context, listen: false).getAllBus();
    Provider.of<AppDataProvider>(context, listen: false).getAllRoutes();
  }

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNodeTicketPrice.dispose();
    _focusNodeProcessingFee.dispose();
    _focusNodeDiscount.dispose();
    ticketPriceController.dispose();
    discountController.dispose();
    processingFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Schedule')),
      body: Form(
        key: _formKeySchedule,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 10,
          ),
          child: ListView(
            children: [
              Consumer<AppDataProvider>(
                builder: (context, provider, _) => DropdownButtonFormField<Bus>(
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  hint: const Text("Select Bus"),
                  value: bus,
                  items: provider.busList
                      .map((bus) => DropdownMenuItem<Bus>(
                            value: bus,
                            child: Text(bus.busName),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      bus = val;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Consumer<AppDataProvider>(
                builder: (context, provider, _) => DropdownButtonFormField<BusRoute>(
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  hint: const Text("Select Route"),
                  value: busRoute,
                  items: provider.routeList
                      .map((route) => DropdownMenuItem<BusRoute>(
                            value: route,
                            child: Text(route.routeName),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      busRoute = val;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return emptyFieldErrMessage;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextFieldCustom(
                focusNode: _focusNodeTicketPrice,
                controller: ticketPriceController,
                hint: 'Ticket Price',
                onChanged: (val) {},
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFieldCustom(
                focusNode: _focusNodeDiscount,
                controller: discountController,
                hint: 'Discount(%)',
                onChanged: (val) {},
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFieldCustom(
                focusNode: _focusNodeProcessingFee,
                controller: processingFeeController,
                hint: 'Processing Fee',
                onChanged: (val) {},
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _selectTime,
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color?>(Colors.blue)),
                    child: const Text("Departure time: "),
                  ),
                  Text(
                    departureTime == null
                        ? "Departure time not choise"
                        : '${formatTimeCustom(departureTime!)} WIB',
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _onAddSchedule,
                    child: const Text("Add schedule"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onAddSchedule() {
    if (departureTime == null) {
      showMsg(context, emptyDateErrMessage);
      return;
    }

    if (_formKeySchedule.currentState!.validate()) {
      BusSchedule busSchedule = BusSchedule(
        scheduleId: TempDB.tableSchedule.length + 1,
        bus: bus!,
        busRoute: busRoute!,
        departureTime: formatTimeCustom(departureTime!),
        ticketPrice: int.parse(ticketPriceController.text),
        discountPercent: int.parse(discountController.text),
        processingFee: int.parse(
          processingFeeController.text,
        ),
      );
      Provider.of<AppDataProvider>(context, listen: false).addSchedule(busSchedule).then((value) {
        if (value.statusCode == 200) {
          showMsg(context, value.message);
          _resetField();
        }
      });
      
    }
  }

  void _selectTime() async {
    final selectedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    setState(() {
      departureTime = selectedTime;
    });
  }

  void _resetField() {
    _focusNodeTicketPrice.unfocus();
    _focusNodeDiscount.unfocus();
    _focusNodeProcessingFee.unfocus();
    ticketPriceController.clear();
    discountController.clear();
    processingFeeController.clear();
    // _formKeySchedule.currentState!.reset();
    bus = null;
    busRoute = null;
    departureTime = null;
    setState(() {});
  }
}
