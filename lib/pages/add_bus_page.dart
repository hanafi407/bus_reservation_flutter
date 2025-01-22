import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/models/bus_model.dart';
import 'package:bus_reservation_udemy/pages/widget/drop_down_custom.dart';
import 'package:bus_reservation_udemy/pages/widget/text_field_custom.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBusPage extends StatefulWidget {
  const AddBusPage({super.key});

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  final _formKeyBus = GlobalKey<FormState>();
  String? typeBus;
  final FocusNode _focusNodeBusNumber = FocusNode();
  final FocusNode _focusNodeBusName = FocusNode();
  final FocusNode _focusNodeTotalSeat = FocusNode();
  TextEditingController busNameController = TextEditingController();
  TextEditingController busNumberController = TextEditingController();
  TextEditingController totalSeatsController = TextEditingController();

  @override
  void dispose() {
    _focusNodeBusNumber.dispose();
    _focusNodeBusName.dispose();
    _focusNodeTotalSeat.dispose();
    busNameController.dispose();
    busNumberController.dispose();
    totalSeatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Bus")),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 10,
        ),
        child: Form(
          key: _formKeyBus,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropDownCustom(
                    hint: "Select Bus",
                    listString: busTypes,
                    val1: typeBus,
                    onChange: (value) {
                      setState(() {
                        typeBus = value;
                      });
                    },
                  ),
                  TextFieldCustom(
                    focusNode: _focusNodeBusNumber,
                    controller: busNumberController,
                    // prefixIcon: Icons.directions_bus,
                    hint: "Bus Number",
                    onChanged: (val) {},
                    textInputType: TextInputType.text,
                  ),
                  TextFieldCustom(
                    focusNode: _focusNodeBusName,
                    controller: busNameController,
                    // prefixIcon: Icons.airport_shuttle,
                    hint: "Bus Name",
                    onChanged: (val) {},
                    textInputType: TextInputType.text,
                  ),
                  TextFieldCustom(
                    focusNode: _focusNodeTotalSeat,
                    controller: totalSeatsController,
                    // prefixIcon: Icons.event_seat,
                    hint: "Total Seats",
                    onChanged: (val) {},
                    textInputType: TextInputType.text,
                  ),
                  ElevatedButton(
                    onPressed: _onAddBus,
                    child: const Text("Add Buss"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onAddBus() {
    if (_formKeyBus.currentState!.validate()) {
      final bus = Bus(
        busId: TempDB.tableBus.length + 1,
        busName: busNameController.text,
        busNumber: busNumberController.text,
        busType: typeBus!,
        totalSeat: int.parse(totalSeatsController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false).addBus(bus).then((value) {
        if (value.responseStatus == ResponseStatus.SAVED) {
          showMsg(context, value.message);
          resetTextField();
        }
      });
    }
  }

  void resetTextField() {
    typeBus = null;
    _focusNodeBusName.unfocus();
    _focusNodeBusNumber.unfocus();
    _focusNodeTotalSeat.unfocus();
    _formKeyBus.currentState!.reset();
    typeBus = null;

    setState(() {});
  }
}
