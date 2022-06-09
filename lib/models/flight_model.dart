import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FlightModel extends Equatable {
  const FlightModel({
    required this.logoUrl,
    required this.companyName,
    required this.departureCity,
    required this.arrivalCity,
    required this.price,
    required this.departureDateTime,
    required this.arrivalDateTime,
  });

  final String logoUrl;
  final String companyName;
  final String departureCity;
  final String arrivalCity;
  final int price;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      logoUrl: json['logo_url'],
      companyName: json['company_name'],
      departureCity: json['departure_city'],
      arrivalCity: json['arrival_city'],
      price: json['price'],
      departureDateTime: (json['departure_ts'] as Timestamp).toDate(),
      arrivalDateTime: (json['arrival_ts'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo_url': logoUrl,
      'company_name': companyName,
      'departure_city': departureCity,
      'arrival_city': arrivalCity,
      'price': price,
      'departure_ts': Timestamp.fromDate(departureDateTime),
      'arrival_ts': Timestamp.fromDate(arrivalDateTime),
    };
  }

  @override
  List<Object?> get props => [
        logoUrl,
        companyName,
        departureCity,
        arrivalCity,
        price,
        departureDateTime,
        arrivalDateTime,
      ];
}
