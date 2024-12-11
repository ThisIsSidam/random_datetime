import 'package:random_datetime/time_range.dart';

class RandomOptions {
  // Private Ranges for each time unit
  late final TimeRange _yearRange;
  late final TimeRange _monthRange;
  late final TimeRange _dayRange;
  late final TimeRange _hourRange;
  late final TimeRange _minuteRange;
  late final TimeRange _secondRange;
  late final TimeRange _millisecondRange;
  late final TimeRange _microsecondRange;

  // Lists to hold the possible values for each DateTime attribute
  late final List<int> years;
  late final List<int> months;
  late final List<int> days;
  late final List<int> hours;
  late final List<int> minutes;
  late final List<int> seconds;
  late final List<int> milliseconds;
  late final List<int> microseconds;

  // Current DateTime to use as reference
  late final DateTime now;

  RandomOptions({
    TimeRange? yearRange,
    TimeRange? monthRange,
    TimeRange? dayRange,
    TimeRange? hourRange,
    TimeRange? minuteRange,
    TimeRange? secondRange,
    TimeRange? millisecondRange,
    TimeRange? microsecondRange,
  }) {
    // Initialize the current DateTime
    now = DateTime.now();

    // Set ranges for each time unit using constructor parameters or default values
    _yearRange = yearRange ?? TimeRange(start: now.year, end: now.year + 5);
    _monthRange = monthRange ?? const TimeRange(start: 1, end: 12);
    _dayRange = dayRange ?? const TimeRange(start: 1, end: 31);
    _hourRange = hourRange ?? const TimeRange(start: 0, end: 23);
    _minuteRange = minuteRange ?? const TimeRange(start: 0, end: 59);
    _secondRange = secondRange ?? const TimeRange(start: 0, end: 59);
    _millisecondRange = millisecondRange ?? const TimeRange(start: 0, end: 999);
    _microsecondRange = microsecondRange ?? const TimeRange(start: 0, end: 999);

    // Initialize the lists based on the ranges provided
    years = _initializeYearList();
    months = _initializeMonthList();
    days = _initializeDayList();
    hours = _initializeHourList();
    minutes = _initializeMinuteList();
    seconds = _initializeSecondList();
    milliseconds = _initializeMillisecondList();
    microseconds = _initializeMicrosecondList();
  }

  List<int> _initializeYearList() {
    final start = _yearRange.start ?? now.year;
    final end =
        _yearRange.end ?? (_yearRange.start != null ? start + 5 : now.year + 5);
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  List<int> _initializeMonthList() {
    final start = _monthRange.start ?? 1;
    final end = _monthRange.end ?? 12;
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  List<int> _initializeDayList() {
    final start = _dayRange.start ?? 1;
    final end = _dayRange.end ?? 31;
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  List<int> _initializeHourList() {
    final start = _hourRange.start ?? 0;
    final end = _hourRange.end ?? 23;
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  List<int> _initializeMinuteList() {
    final start = _minuteRange.start ?? 0;
    final end = _minuteRange.end ?? 59;
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  List<int> _initializeSecondList() {
    final start = _secondRange.start ?? 0;
    final end = _secondRange.end ?? 59;
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  List<int> _initializeMillisecondList() {
    final start = _millisecondRange.start ?? 0;
    final end = _millisecondRange.end ?? 999;
    return List<int>.generate(end - start + 1, (index) => start + index);
  }

  List<int> _initializeMicrosecondList() {
    final start = _microsecondRange.start ?? 0;
    final end = _microsecondRange.end ?? 999;
    return List<int>.generate(end - start + 1, (index) => start + index);
  }
}
