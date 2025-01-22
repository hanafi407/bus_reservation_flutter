import 'package:bus_reservation_udemy/models/bus_route.dart';
import 'package:bus_reservation_udemy/pages/widget/text_field_custom.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({super.key});

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  String? cityFrom, cityTo;
  final _formKeyRoute = GlobalKey<FormState>();
  TextEditingController distanceController = TextEditingController();
  final FocusNode _focusNodeDistance = FocusNode();

  @override
  void dispose() {
    _focusNodeDistance.dispose();
    distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Route')),
      body: Form(
          key: _formKeyRoute,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: cityFrom,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyFieldErrMessage;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text("From"),
                      isExpanded: true,
                      items: cities
                          .map(
                            (city) => DropdownMenuItem<String>(
                              value: city,
                              enabled: cityTo != city,
                              child: cityTo == city && cityTo != null
                                  ? Text(
                                      city,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Text(city),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          cityFrom = value;
                        });
                      },
                    ),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: cityTo,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyFieldErrMessage;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text("To"),
                      isExpanded: true,
                      items: cities
                          .map(
                            (city) => DropdownMenuItem<String>(
                              value: city,
                              enabled: cityFrom != city,
                              child: cityFrom == city && cityFrom != null
                                  ? Text(
                                      city,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Text(city),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          cityTo = value;
                        });
                      },
                    ),
                    TextFieldCustom(
                      focusNode: _focusNodeDistance,
                      controller: distanceController,
                      hint: "Distance in KM",
                      onChanged: (val) {},
                      textInputType: TextInputType.text,
                    ),
                    ElevatedButton(onPressed: _onPressed, child: const Text("Add Route"))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  _onPressed() {
    if (_formKeyRoute.currentState!.validate()) {
      BusRoute busRoute = BusRoute(
          routeName: "$cityFrom - $cityTo",
          cityFrom: cityFrom!,
          cityTo: cityTo!,
          distanceInKm: double.parse(distanceController.text));

      Provider.of<AppDataProvider>(context, listen: false).addRoute(busRoute).then((value) {
        if (value.responseStatus == ResponseStatus.SAVED) {
          showMsg(context, value.message);
          _resetField();
        }
      });
    }
  }

  void _resetField() {
    _focusNodeDistance.unfocus();
    _formKeyRoute.currentState!.reset();
    cityFrom = null;
    cityTo = null;
    setState(() {});
  }
}
