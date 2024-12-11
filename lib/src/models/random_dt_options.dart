import 'package:random_datetime/src/enums/days_in_months.dart';

class RandomDTOptions {
  late final DateTime _now;
  final bool allowPastDates;

  late final List<int> _years;
  late final List<int> _months;
  late final List<int> _days;
  late final List<int> _hours;
  late final List<int> _minutes;
  late final List<int> _seconds;
  late final List<int> _milliseconds;
  late final List<int> _microseconds;

  RandomDTOptions({
    this.allowPastDates = false,
    int? startYear,
    int? endYear,
    List<int>? months,
    List<int>? days,
    List<int>? hours,
    List<int>? minutes,
    List<int>? seconds,
    List<int>? milliseconds,
    List<int>? microseconds,
  }) {
    _now = DateTime.now();
    startYear ??= allowPastDates ? 1970 : _now.year;
    endYear ??= _now.year + 5;
    _years = List<int>.generate(
      endYear - startYear + 1,
      (int i) => i + (startYear ?? _now.year),
    );
    _months = months ?? <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    _days = days ?? List<int>.generate(31, (int index) => index + 1);
    _hours = hours ?? List<int>.generate(24, (int index) => index);
    _minutes = minutes ?? List<int>.generate(60, (int index) => index);
    _seconds = seconds ?? List<int>.generate(60, (int index) => index);
    _milliseconds =
        milliseconds ?? List<int>.generate(1000, (int index) => index);
    _microseconds =
        microseconds ?? List<int>.generate(1000, (int index) => index);
  }

  List<int> getValidYears() {
    return _years.where((int year) {
      // If the year is in the future, it is valid
      if (year > _now.year || allowPastDates) {
        return true;
      }

      // If the year is the current year, we need to check months, days,
      if (year == _now.year) {
        final bool isValidMonth =
            _months.any((int month) => month >= _now.month);
        final bool isValidDay =
            _now.month == 12 || _days.any((int day) => day >= _now.day);

        // A year is valid if any of the time units (month, day, hour, minute) conditions are met
        return isValidMonth && isValidDay;
      }

      // If the year is in the past, it is not valid unless allowPastDates is true
      return false;
    }).toList();
  }

  List<int> getValidMonths(int year) {
    if (year > _now.year || allowPastDates) {
      return _months;
    } else if (year == _now.year) {
      return _months.sublist(0, _now.month);
    } else {
      return <int>[];
    }
  }

  List<int> getValidDays(int year, int month) {
    final int maxDays = DaysInMonth.daysCountFromNumber(month, year: year);

    if (year > _now.year || allowPastDates) {
      return _days.where((int day) => day <= maxDays).toList();
    } else if (month == _now.month && year == _now.year) {
      return _days
          .where((int day) => day > _now.day && day <= maxDays)
          .toList();
    } else {
      return <int>[];
    }
  }

  /// Handling precision to this level seems unnecessary
  ///
  /// All the checks above is for when allowPastDates is false and the
  /// metric is close the the metric from current time, hence control it
  /// and give updated time, but in [getValidDays], we handle it so that
  /// the current day is not included so metric can't come close.
  List<int> getValidHours(int day) => _hours;

  List<int> getValidMinutes(int hour) => _minutes;

  List<int> getValidSeconds(int minute) => _seconds;

  List<int> getValidMilliseconds(int second) => _milliseconds;

  List<int> getValidMicroseconds(int millisecond) => _microseconds;
}
