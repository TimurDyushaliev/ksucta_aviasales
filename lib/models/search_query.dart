class SearchQuery {
  const SearchQuery({
    required this.departureCity,
    required this.arrivalCity,
    required this.dateTime,
  });

  final String departureCity;
  final String arrivalCity;
  final DateTime dateTime;
}
