import 'package:aviasales/models/flight_model.dart';
import 'package:aviasales/models/search_query.dart';
import 'package:aviasales/resource/firestore_collection_ids.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FlightsPageController {
  static Future<List<FlightModel>> search(SearchQuery query) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(FirestoreCollectionIds.flights)
        .where(
          'departure_city',
          isEqualTo: query.departureCity,
        )
        .where(
          'arrival_city',
          isEqualTo: query.arrivalCity,
        )
        .where(
          'departure_ts',
          isGreaterThanOrEqualTo: Timestamp.fromDate(query.dateTime),
        )
        .get();

    return snapshot.docs
        .map((doc) => FlightModel.fromJson(doc.data()))
        .toList();
  }
}
