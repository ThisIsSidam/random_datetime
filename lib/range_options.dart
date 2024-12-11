import 'package:random_datetime/range.dart';

class RandomOptions {
  // Private Ranges for each time unit
  late final Range _yearRange;
  late final Range _monthRange;
  late final Range _dayRange;
  late final Range _hourRange;
  late final Range _minuteRange;
  late final Range _secondRange;
  late final Range _millisecondRange;
  late final Range _microsecondRange;

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
    Range? yearRange,
    Range? monthRange,
    Range? dayRange,
    Range? hourRange,
    Range? minuteRange,
    Range? secondRange,
    Range? millisecondRange,
    Range? microsecondRange,
  }) {
    // Initialize the current DateTime
    now = DateTime.now();

    // Set ranges for each time unit using constructor parameters or default values
    _yearRange = yearRange ?? Range(start: now.year, end: now.year + 5);
    _monthRange = monthRange ?? const Range(start: 1, end: 12);
    _dayRange = dayRange ?? const Range(start: 1, end: 31);
    _hourRange = hourRange ?? const Range(start: 0, end: 23);
    _minuteRange = minuteRange ?? const Range(start: 0, end: 59);
    _secondRange = secondRange ?? const Range(start: 0, end: 59);
    _millisecondRange = millisecondRange ?? const Range(start: 0, end: 999);
    _microsecondRange = microsecondRange ?? const Range(start: 0, end: 999);

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

  // Helper method to handle wraparound for circular ranges
  List<int> _initializeCircularRange(int start, int end, int max) {
    if (end >= start) {
      return List<int>.generate(end - start + 1, (index) => start + index);
    } else {
      // Wraparound case: from start to max, then from 0 to end
      return [
        ...List<int>.generate(max - start + 1, (index) => start + index),
        ...List<int>.generate(end + 1, (index) => index)
      ];
    }
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
    return _initializeCircularRange(start, end, 12);
  }

  List<int> _initializeDayList() {
    final start = _dayRange.start ?? 1;
    final end = _dayRange.end ?? 31;
    return _initializeCircularRange(start, end, 31);
  }

  List<int> _initializeHourList() {
    final start = _hourRange.start ?? 0;
    final end = _hourRange.end ?? 23;
    return _initializeCircularRange(start, end, 23);
  }

  List<int> _initializeMinuteList() {
    final start = _minuteRange.start ?? 0;
    final end = _minuteRange.end ?? 59;
    return _initializeCircularRange(start, end, 59);
  }

  List<int> _initializeSecondList() {
    final start = _secondRange.start ?? 0;
    final end = _secondRange.end ?? 59;
    return _initializeCircularRange(start, end, 59);
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
