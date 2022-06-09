extension DateTimeExtensions on DateTime {
  String toHourMinuteString() => '$hour:$minute';

  String get ruShortWeekday {
    switch (weekday) {
      case 1:
        return 'пн';
      case 2:
        return 'вт';
      case 3:
        return 'ср';
      case 4:
        return 'чт';
      case 5:
        return 'пт';
      case 6:
        return 'сб';
      case 7:
        return 'вс';
      default:
        throw Exception('Invalid value: $weekday. Available range: [1..7]');
    }
  }

  String get ruShortDayMonth {
    String? month;
    switch (this.month) {
      case 1:
        month = 'янв';
        break;
      case 2:
        month = 'фев';
        break;
      case 3:
        month = 'март';
        break;
      case 4:
        month = 'апр';
        break;
      case 5:
        month = 'май';
        break;
      case 6:
        month = 'июнь';
        break;
      case 7:
        month = 'июль';
        break;
      case 8:
        month = 'авг';
        break;
      case 9:
        month = 'сен';
        break;
      case 10:
        month = 'окт';
        break;
      case 11:
        month = 'нояб';
        break;
      case 12:
        month = 'дек';
    }
    return '$day$month';
  }
}
