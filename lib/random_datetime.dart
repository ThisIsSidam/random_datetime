library;

import 'dart:math';

import 'package:random_datetime/src/enums/days_in_months.dart';
import 'package:random_datetime/src/models/range_options.dart';
import 'package:random_datetime/src/utils/random_ext.dart';

class RandomDateTime {
  final Random _random;
  final RandomOptions options;

  RandomDateTime({RandomOptions? options})
      : _random = Random(),
        options = options ?? RandomOptions();

  DateTime random() {
    final int year = _randomYear();
    final int month = _randomMonth(year);
    final int day = _randomDay(year, month);
    final int hour = _randomHour(day);
    final int minute = _randomMinute(hour);
    final int second = _randomSecond(minute);
    final int millisecond = _randomMillisecond(second);
    final int microsecond = _randomMicrosecond(millisecond);

    return DateTime(
        year, month, day, hour, minute, second, millisecond, microsecond);
  }

  int _randomYear() {
    return _random.randomPick(options.years);
  }

  int _randomMonth(int year) {
    if (year == options.now.year) {
      return _random.randomPick(options.months.sublist(options.now.month - 1));
    } else {
      return _random.randomPick(options.months);
    }
  }

  int _randomDay(int year, int month) {
    if (month == options.now.month) {
      return options.now.day +
          _random.nextInt(DaysInMonth.daysCountFromNumber(month, year: year) -
              options.now.day +
              1);
    } else {
      return _random
              .nextInt(DaysInMonth.daysCountFromNumber(month, year: year)) +
          1;
    }
  }

  int _randomHour(int day) {
    if (day == options.now.day) {
      return options.now.hour + _random.nextInt(60 - options.now.hour + 1);
    } else {
      return _random.nextInt(24);
    }
  }

  int _randomMinute(int hour) {
    if (hour == options.now.hour) {
      return options.now.minute + _random.nextInt(60 - options.now.minute + 1);
    } else {
      return _random.nextInt(60);
    }
  }

  int _randomSecond(int minute) {
    if (minute == options.now.minute) {
      return options.now.second + _random.nextInt(60 - options.now.second + 1);
    } else {
      return _random.nextInt(60);
    }
  }

  int _randomMillisecond(int second) {
    if (second == options.now.second) {
      return options.now.millisecond +
          _random.nextInt(1000 - options.now.millisecond + 1);
    } else {
      return _random.nextInt(1000);
    }
  }

  int _randomMicrosecond(int millisecond) {
    if (millisecond == options.now.millisecond) {
      return options.now.microsecond +
          _random.nextInt(1000 - options.now.microsecond + 1);
    } else {
      return _random.nextInt(1000);
    }
  }
}
