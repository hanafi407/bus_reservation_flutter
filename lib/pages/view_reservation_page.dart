import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/reservation_expansions_item.dart';
import 'package:bus_reservation_udemy/pages/widget/expansion_body.dart';
import 'package:bus_reservation_udemy/pages/widget/expansion_header.dart';
import 'package:bus_reservation_udemy/pages/widget/search_button_custom.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewReservationPage extends StatefulWidget {
  const ViewReservationPage({super.key});

  @override
  State<ViewReservationPage> createState() => _ViewReservationPageState();
}

class _ViewReservationPageState extends State<ViewReservationPage> {
  bool isTrue = true;
  List<ReservationExpantionsItem> items = [];
  late AppDataProvider appDataProvider;

  _getData() async {
    appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    final reservation = await appDataProvider.getAllReservation();
    items = appDataProvider.getExpansionitem(reservation);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    if (isTrue) {
      _getData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Reservation")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchButtonCustom(onButton: (value) {
                _onSearch(value);
              }),
              const SizedBox(height: 5),
              _buildPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          items[index].isExpanded = isExpanded;
        });
      },
      children: items.map<ExpansionPanel>((item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ExpansionHeader(header: item.header);
          },
          body: ExpansionBody(body: item.body),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Future _onSearch(String value) async {
    List<BusReservation> reservationsMobile = await appDataProvider.getReservationsByMobile(value);

    setState(() {
      items = appDataProvider.getExpansionitem(reservationsMobile);
    });
  }
}
