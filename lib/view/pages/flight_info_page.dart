import 'package:aviasales/models/flight_model.dart';
import 'package:aviasales/resource/string_resource.dart';
import 'package:aviasales/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightInfPage extends StatelessWidget {
  const FlightInfPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final FlightModel model;

  @override
  Widget build(BuildContext context) {
    final price =
        NumberFormat('#,##,000').format(model.price).replaceAll(',', ' ');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.companyName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 5),
            Text(
              '${_getTimeOfFlight()} в полете',
              style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.departureDateTime.toHourMinuteString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${model.departureDateTime.ruShortDayMonth}, ${model.departureDateTime.ruShortWeekday}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Text(
                  model.departureCity,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Icon(Icons.arrow_downward_outlined, color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.arrivalDateTime.toHourMinuteString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${model.arrivalDateTime.ruShortDayMonth}, ${model.arrivalDateTime.ruShortWeekday}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Text(
                  model.arrivalCity,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('${StringResource.buy}: ${price}c'),
        ),
      ),
    );
  }

  String _getTimeOfFlight() {
    final differenceInHours =
        model.arrivalDateTime.hour - model.departureDateTime.hour;
    final differenceInMinute =
        model.arrivalDateTime.minute - model.departureDateTime.minute;
    if (differenceInMinute > 0) {
      return '$differenceInHoursч $differenceInMinuteм';
    } else {
      return '$differenceInHoursч';
    }
  }
}
