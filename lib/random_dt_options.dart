import 'package:random_datetime/enums/days_in_months.dart';

/// A class to store the range for each unit of time
/// Both [start] and [end] attributes are nullable.
///
/// If [start] is null, the current value of unit is taken
/// If [end] is null, the max value of unit is taken, i.e.,
/// for months, 12 is max value, for hours, 23 is max value,
/// for years futureYearLimit of [RandomDTOptions] is max value.
///
/// Keep in mind that [start] and [end] are both inclusive
///
/// To keep a single value using range, set [start] and [end] to the same value
class TimeRange {
  final int? start;
  final int? end;

  const TimeRange({this.start, this.end});
}

class RandomDTOptions {
  /// The [DateTime] instance which is initialized with .now() and
  /// used as reference of current time for the whole lifecycle of
  /// the [RandomDTOptions] class.
  late final DateTime _now;

  /// Whether to allow resulting [DateTime] object to be from the past.
  final bool allowPastDates;

  final int futureYearLimit;

  /// The list of years which are used to filter and then pick the random
  /// year from.
  late final List<int> _years;

  /// The list of months which are used to filter and then pick the random
  /// month from.
  late final List<int> _months;

  /// The list of days which are used to filter and then pick the random
  /// day from.
  late final List<int> _days;

  /// The list of hours which are used to filter and then pick the random
  /// hour from.
  late final List<int> _hours;

  /// The list of minutes which are used to filter and then pick the random
  /// minute from.
  late final List<int> _minutes;

  /// The list of seconds which are used to filter and then pick the random
  /// second from.
  late final List<int> _seconds;

  /// The list of milliseconds which are used to filter and then pick the random
  /// millisecond from.
  late final List<int> _milliseconds;

  /// The list of microseconds which are used to filter and then pick the random
  /// microsecond from.
  late final List<int> _microseconds;

  /// Initialize [RandomDTOptions]
  ///
  /// * [allowPastDates] - Whether to allow resulting [DateTime] unit's
  /// possible values lists to include past dates.
  ///
  /// * [startYear] and [endYear] are not attributes, but they are used to
  /// initialize [_years]. By default, [startYear] is 1970 with [allowPastDates]
  /// true else the current year. And [endYear] is [startYear] + 5 by default.
  ///
  /// * [months], [days], [hours], [minutes], [seconds], [milliseconds] and
  /// [microseconds] are the possible values lists for the corresponding units.
  /// If not given the defaults are chosen.
  ///
  /// The defaults for these are what you expect, a list of 1 to 12 for months.
  /// 0 to 59 for hours, seconds and so on.
  ///
  /// For days although, the default is a list of 1 to 31 and it is filtered
  /// using the current month and year for different months and leap year later
  /// on in the [getValidDays] method.
  RandomDTOptions({
    this.allowPastDates = false,
    this.futureYearLimit = 5,
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
    endYear ??= _now.year + futureYearLimit;
    _years = List<int>.generate(
      endYear - startYear + 1,
      (int i) => i + (startYear ?? (allowPastDates ? 1970 : _now.year)),
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

  // With range constructor
  RandomDTOptions.withRange({
    this.allowPastDates = false,
    this.futureYearLimit = 5,
    TimeRange yearRange = const TimeRange(start: 1970, end: 5),
    TimeRange monthRange = const TimeRange(start: 1, end: 12),
    TimeRange dayRange = const TimeRange(start: 1, end: 31),
    TimeRange hourRange = const TimeRange(start: 0, end: 23),
    TimeRange minuteRange = const TimeRange(start: 0, end: 59),
    TimeRange secondRange = const TimeRange(start: 0, end: 59),
    TimeRange millisecondRange = const TimeRange(start: 0, end: 999),
    TimeRange microsecondRange = const TimeRange(start: 0, end: 999),
  }) : _now = DateTime.now() {
    final int startYear = allowPastDates ? yearRange.start ?? 1970 : _now.year;
    final int endYear = yearRange.end ?? _now.year + futureYearLimit;
    _years = List<int>.generate(
      endYear - startYear + 1,
      (int i) => i + (startYear),
    );
    _months = _generateRangeList(monthRange.start!, monthRange.end!, 1, 12);

    _days = _generateRangeList(dayRange.start!, dayRange.end!, 1, 31);

    _hours = _generateRangeList(hourRange.start!, hourRange.end!, 0, 23);

    _minutes = _generateRangeList(minuteRange.start!, minuteRange.end!, 0, 59);

    _seconds = _generateRangeList(secondRange.start!, secondRange.end!, 0, 59);

    _milliseconds = _generateRangeList(
        millisecondRange.start!, millisecondRange.end!, 0, 999);

    _microseconds = _generateRangeList(
        microsecondRange.start!, microsecondRange.end!, 0, 999);
  }

  /// Helper method to generate a list of integers within a specified range
  ///
  /// [start] The starting value of the range
  /// [end] The ending value of the range (exclusive)
  /// [max] The maximum possible value for the range
  /// (e.g., 12 for months, 31 for days)
  ///
  /// The method also handles wrap-around ranges by creating a list that
  /// includes all values from start to max and then from 1 to end
  static List<int> _generateRangeList(int start, int end, int min, int max) {
    start = start.clamp(min, max);
    end = end.clamp(min, max);

    final int rangeSize =
        end < start ? (max - start + 1) + (end - min + 1) : (end - start + 1);

    return List<int>.generate(rangeSize, (int i) {
      final int value = start + i;
      return min + ((value - min) % (max - min + 1));
    });
  }

  /// Get valid years from [_years], which is the list of possible years
  /// filtered using the other parameters passed.
  ///
  /// For example:
  ///
  /// With default [allowPastDates], startYear as 2024,
  /// endYear as 2026, and months as [1, 2].
  ///
  /// The [_years] would be [2024, 2025, 2026], and [_months] would be [1, 2].
  /// These are possible values.
  ///
  /// Now, since [allowPastDates] is false by default. 2024 isn't a valid year,
  /// since months 1 and 2 have already passed. Hence, valid years would only
  /// be [2025, 2026].
  ///
  /// Similarly, if days were passed as [1, 3], and since current month is
  /// december, the dates 1 and 2 would not come again.
  ///
  /// And moreover, further units can also be taken in but the method does not
  /// as it can be unnecessary.
  ///
  /// To handle that, the [getValidDays] method does not include the current
  /// day, hence hours, minutes, etc will not be last intances.
  /// (Unless it is the last day of year).
  List<int> getValidYears() {
    return _years.where((int year) {
      // If the year is in the future, it is valid
      if (year > _now.year || allowPastDates) {
        return true;
      }

      // If the year is the current year, we need to check for valid months
      // and days. Because if an year is chosen but does not has valid months
      // in it. That would backfire.
      if (year == _now.year) {
        final bool hasValidMonth =
            _months.any((int month) => month >= _now.month);
        final bool hasValidDay =
            _now.month == 12 && _days.any((int day) => day > _now.day);

        // A year is valid if any of the time units (month, day, hour, minute)
        // conditions are met
        return hasValidMonth && hasValidDay;
      }

      // If the year is in the past, it is not valid unless allowPastDates is
      // true
      return false;
    }).toList();
  }

  /// Get valid months based on the passed year.
  ///
  /// If year is greater than current year or [allowPastDates] is true, it
  /// passes the whole list of possible months.
  /// If not, it returns a sublist of only current and future months.
  /// Else, it returns an empty list.
  List<int> getValidMonths(int year) {
    if (year > _now.year || allowPastDates) {
      return _months;
    } else if (year == _now.year) {
      return _months.sublist(_now.month - 1);
    } else {
      return <int>[];
    }
  }

  /// Get valid days based on the passed month.
  ///
  /// If year or month is greater than current year or month or [allowPastDates]
  /// is true, it passes the whole list of possible days.
  /// If not, it returns a sublist of only current and future days.
  /// Else, it returns an empty list.
  List<int> getValidDays(int year, int month) {
    final int maxDays = DaysInMonth.daysCountFromNumber(month, year: year);

    if (year > _now.year || month > _now.month || allowPastDates) {
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

  /// Returns list of possible hours
  List<int> getValidHours(int day) => _hours;

  /// Returns list of possible minutes
  List<int> getValidMinutes(int hour) => _minutes;

  /// Returns list of possible seconds
  List<int> getValidSeconds(int minute) => _seconds;

  /// Returns list of possible milliseconds
  List<int> getValidMilliseconds(int second) => _milliseconds;

  /// Returns list of possible microseconds
  List<int> getValidMicroseconds(int millisecond) => _microseconds;

  /// Converts the  class's attributes to string
  /// It although does not include units after hours as their
  /// list values can be large, ex: milliseconds' list if of 0 to 999.
  /// And also because it is thought to not cause errors.
  @override
  String toString() {
    return '''RandomDTOptions{
      _now: $_now,
      allowPastDates: $allowPastDates
      futureYearLimit: $futureYearLimit
      Years: ${_years.first} - ${_years.last} (${_years.length} total)
      Months: $_months
      Days: $_days
      Hours: $_hours
    }''';
  }

  /// Returns the hash code
  @override
  int get hashCode => Object.hash(
        allowPastDates,
        futureYearLimit,
        _years,
        _months,
        _days,
        _hours,
        _minutes,
        _seconds,
        _milliseconds,
        _microseconds,
      );

  /// Checks if two [RandomDTOptions] objects are equal
  /// compares list through the elements in them rather than the list itself
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RandomDTOptions &&
            runtimeType == other.runtimeType &&
            allowPastDates == other.allowPastDates &&
            futureYearLimit == other.futureYearLimit &&
            _listEquals(_years, other._years) &&
            _listEquals(_months, other._months) &&
            _listEquals(_days, other._days) &&
            _listEquals(_hours, other._hours) &&
            _listEquals(_minutes, other._minutes) &&
            _listEquals(_seconds, other._seconds) &&
            _listEquals(_milliseconds, other._milliseconds) &&
            _listEquals(_microseconds, other._microseconds);
  }

  /// Checks if two lists contain the same elements
  bool _listEquals(List<int> a, List<int> b) {
    if (a.length != b.length) {
      return false;
    }

    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}
