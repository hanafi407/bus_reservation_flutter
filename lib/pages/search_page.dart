import 'package:bus_reservation_udemy/drawer/main_drawer.dart';
import 'package:bus_reservation_udemy/pages/widget/drop_down_custom.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final double width;
  const SearchPage({super.key,  this.width=0});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? cityFrom, cityTo;
  DateTime? departureDate;
  final _formKeyLogin = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool width500 = widget.width > 700;
    return Scaffold(
      drawer: width500 ? null : const MainDrawer(),
      appBar: AppBar(title: const Text("Search Page")),
      body: Form(
          key: _formKeyLogin,
          child: width500
              ? Row(
                  children: [
                    const MainDrawer(),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        children: [
                          const Text(
                            "From:",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          DropDownCustom<String>(
                            listString: cities,
                            hint: "Select city...",
                            val1: cityFrom,
                            val2: cityTo,
                            onChange: (val) {
                              setState(() {
                                cityFrom = val;
                              });
                            },
                          ),
                          const Text(
                            "To:",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          DropDownCustom(
                            listString: cities,
                            hint: "Select city...",
                            val1: cityTo,
                            val2: cityFrom,
                            onChange: (val) {
                              setState(() {
                                cityTo = val;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: _selectDate,
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color?>(Colors.blue)),
                                child: const Text("Departure date: "),
                              ),
                              Text(departureDate == null
                                  ? "Departure date not choise"
                                  : myFormatDate(departureDate!, format: "EEE dd LLL ,yyyy")),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: _onSearch,
                                child: const Text("Search"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    children: [
                      const Text(
                        "From:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      DropDownCustom<String>(
                        listString: cities,
                        hint: "Select city...",
                        val1: cityFrom,
                        val2: cityTo,
                        onChange: (val) {
                          setState(() {
                            cityFrom = val;
                          });
                        },
                      ),
                      const Text(
                        "To:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      DropDownCustom(
                        listString: cities,
                        hint: "Select city...",
                        val1: cityTo,
                        val2: cityFrom,
                        onChange: (val) {
                          setState(() {
                            cityTo = val;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _selectDate,
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color?>(Colors.blue)),
                            child: const Text("Departure date: "),
                          ),
                          Text(departureDate == null
                              ? "Departure date not choise"
                              : myFormatDate(departureDate!, format: "EEE dd LLL ,yyyy")),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _onSearch,
                            child: const Text("Search"),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    setState(() {
      departureDate = selectedDate;
    });
  }

  void _onSearch() {
    if (departureDate == null) {
      showMsg(context, emptyDateErrMessage);
      return;
    }
    if (_formKeyLogin.currentState!.validate()) {
      Provider.of<AppDataProvider>(context, listen: false)
          .getRouteByCityFromAndCityTo(cityFrom!, cityTo!)
          .then((busRoute) {
        Navigator.pushNamed(context, routeNameSearchResultPage,
            arguments: [busRoute, myFormatDate(departureDate!)]);
      });
    }
  }
}
