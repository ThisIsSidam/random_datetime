import 'package:random_datetime/random_datetime.dart';
import 'package:random_datetime/random_dt_options.dart';

void main() {
  print('Example 1: Default Random DateTime');
  final RandomDateTime defaultRandom = RandomDateTime();
  final DateTime defaultDateTime = defaultRandom.random();
  print('Default Random DateTime: $defaultDateTime\n');

  print('Example 2: Random DateTime with Past Dates');
  final RandomDTOptions pastDatesOptions = RandomDTOptions(
    allowPastDates: true,
    startYear: 2000,
    endYear: 2023,
  );
  final RandomDateTime pastRandom = RandomDateTime(options: pastDatesOptions);
  final DateTime pastDateTime = pastRandom.random();
  print('Past Random DateTime: $pastDateTime\n');

  print('Example 3: Custom Month and Day Constraints');
  final RandomDTOptions customMonthDayOptions = RandomDTOptions(
    months: <int>[6, 7, 8], // Only specific months
    days: <int>[1, 15, 30], // Only specific days
    futureYearLimit: 3, // Limit future years to next 3 years
  );
  final RandomDateTime customRandom =
      RandomDateTime(options: customMonthDayOptions);
  final DateTime customDateTime = customRandom.random();
  print('Custom Random DateTime: $customDateTime\n');

  print('Example 4: Time-Specific Constraints');
  final RandomDTOptions timeConstraintsOptions = RandomDTOptions(
    hours: <int>[9, 10, 11, 12], // Only specific hours
    minutes: <int>[0, 15, 30, 45], // Quarter-hour intervals
  );
  final RandomDateTime timeRandom =
      RandomDateTime(options: timeConstraintsOptions);
  final DateTime timeConstraintsDateTime = timeRandom.random();
  print('Time-Constrained Random DateTime: $timeConstraintsDateTime\n');

  print('Example 5: Multiple Random DateTimes');
  final RandomDTOptions multipleRandomOptions = RandomDTOptions(
    futureYearLimit: 1,
  );
  final RandomDateTime multipleRandom =
      RandomDateTime(options: multipleRandomOptions);

  print('5 Random Future DateTimes:');
  for (int i = 0; i < 5; i++) {
    print(multipleRandom.random());
  }

  print('\nExample 6: Year Range with withRange Constructor');
  final RandomDTOptions yearRangeOptions = RandomDTOptions.withRange(
    allowPastDates: true,
    yearRange: const TimeRange(start: 1990, end: 2000),
  );
  final RandomDateTime yearRangeRandom =
      RandomDateTime(options: yearRangeOptions);
  final DateTime yearRangeDateTime = yearRangeRandom.random();
  print('Year Range Random DateTime: $yearRangeDateTime\n');

  print('Example 7: Month and Day Range with withRange Constructor');
  final RandomDTOptions monthDayRangeOptions = RandomDTOptions.withRange(
    monthRange: const TimeRange(start: 3, end: 5), // March to May
    dayRange: const TimeRange(start: 10, end: 20), // Days from 10 to 20
  );
  final RandomDateTime monthDayRangeRandom =
      RandomDateTime(options: monthDayRangeOptions);
  final DateTime monthDayRangeDateTime = monthDayRangeRandom.random();
  print('Month and Day Range Random DateTime: $monthDayRangeDateTime\n');

  print('Example 8: Hour and Minute Range with withRange Constructor');
  final RandomDTOptions hourMinuteRangeOptions = RandomDTOptions.withRange(
    hourRange: const TimeRange(start: 9, end: 17),
    minuteRange: const TimeRange(start: 0, end: 30), // only first half of hour
  );
  final RandomDateTime hourMinuteRangeRandom =
      RandomDateTime(options: hourMinuteRangeOptions);
  final DateTime hourMinuteRangeDateTime = hourMinuteRangeRandom.random();
  print('Hour and Minute Range Random DateTime: $hourMinuteRangeDateTime\n');

  print('Example 9: Comprehensive Range Constraints');
  final RandomDTOptions comprehensiveRangeOptions = RandomDTOptions.withRange(
    yearRange: const TimeRange(start: 2020, end: 2025),
    monthRange: const TimeRange(start: 6, end: 9),
    dayRange: const TimeRange(start: 1, end: 15),
    hourRange: const TimeRange(start: 8, end: 18),
    minuteRange: const TimeRange(start: 0, end: 45),
  );
  final RandomDateTime comprehensiveRangeRandom =
      RandomDateTime(options: comprehensiveRangeOptions);
  final DateTime comprehensiveRangeDateTime = comprehensiveRangeRandom.random();
  print('Comprehensive Range Random DateTime: $comprehensiveRangeDateTime\n');
}
