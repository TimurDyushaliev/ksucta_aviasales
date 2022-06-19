import 'package:aviasales/controllers/flights_page_controller.dart';
import 'package:aviasales/models/flight_model.dart';
import 'package:aviasales/models/search_query.dart';
import 'package:aviasales/utils/extensions.dart';
import 'package:aviasales/view/pages/flight_info_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightsPage extends StatefulWidget {
  const FlightsPage({
    Key? key,
    required this.searchQuery,
    required this.passengersAmount,
  }) : super(key: key);

  final SearchQuery searchQuery;
  final int passengersAmount;

  @override
  State<FlightsPage> createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: FlightsPageController.search(widget.searchQuery),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final models = snapshot.data as List<FlightModel>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ListView.builder(
                itemCount: models.length,
                itemBuilder: (context, index) {
                  final model = models[index];
                  final price = model.price * widget.passengersAmount;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlightInfPage(
                                model: model.copyWith(
                              price: price,
                            )),
                          ));
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          model.logoUrl,
                          width: 60,
                          height: 60,
                        ),
                        title: Text(model.companyName),
                        subtitle: Text(
                          '${model.departureDateTime.toHourMinuteString()} - ${model.arrivalDateTime.toHourMinuteString()}',
                        ),
                        trailing: Text(
                          '${NumberFormat('#,##,000').format(price).replaceAll(',', ' ')}c',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
