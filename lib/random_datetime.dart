import 'dart:math' show Random;

import 'package:random_datetime/random_dt_options.dart';
import 'package:random_datetime/src/utils/random_ext.dart';

class RandomDateTime {
  /// Instance of [Random] class which is used for generating random elements
  /// from lists
  final Random _random;

  /// Options passed down by the user for specifying the generation of
  /// random [DateTime] elements
  final RandomDTOptions options;

  /// Constructs a [RandomDateTime] instance
  RandomDateTime({RandomDTOptions? options})
      : _random = Random(),
        options = options ?? RandomDTOptions();

  /// Method which generates the random [DateTime] instance using the
  /// options passed, if not passed, uses the default options.
  ///
  /// If an error occurs, it prints out the log and tries to print another
  DateTime random() {
    Object? caughtE;
    for (int i = 0; i < 3; i++) {
      try {
        final int year = _random.randomPick(options.getValidYears());
        final int month = _random.randomPick(options.getValidMonths(year));
        final int day = _random.randomPick(options.getValidDays(year, month));
        final int hour = _random.randomPick(options.getValidHours(day));
        final int minute = _random.randomPick(options.getValidMinutes(hour));
        final int second = _random.randomPick(options.getValidSeconds(minute));
        final int millisecond =
            _random.randomPick(options.getValidMilliseconds(second));
        final int microsecond =
            _random.randomPick(options.getValidMicroseconds(millisecond));

        return DateTime(
            year, month, day, hour, minute, second, millisecond, microsecond);
      } catch (e) {
        caughtE = e;
      }
    }

    // Throw the error being repetitively caught if present
    throw caughtE ??
        '''
      Could not generate random DateTime object
      
      Report a bug at https://github.com/ThisIsSidam/random_datetime/issues
      
      Don't forget to add  this to the report:
      ${options.toString()}
    ''';
  }
}
