import 'package:random_datetime/random_datetime.dart';
import 'package:random_datetime/random_dt_options.dart';

void main() {
  // Example 1: Default usage - generates a random future DateTime
  print('Example 1: Default Random DateTime');
  final RandomDateTime defaultRandom = RandomDateTime();
  final DateTime defaultDateTime = defaultRandom.random();
  print('Default Random DateTime: $defaultDateTime\n');

  // Example 2: Allow past dates with custom year range
  print('Example 2: Random DateTime with Past Dates');
  final RandomDTOptions pastDatesOptions = RandomDTOptions(
    allowPastDates: true,
    startYear: 2000,
    endYear: 2023,
  );
  final RandomDateTime pastRandom = RandomDateTime(options: pastDatesOptions);
  final DateTime pastDateTime = pastRandom.random();
  print('Past Random DateTime: $pastDateTime\n');

  // Example 3: Custom month and day constraints
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

  // Example 4: Time-specific constraints
  print('Example 4: Time-Specific Constraints');
  final RandomDTOptions timeConstraintsOptions = RandomDTOptions(
    hours: <int>[9, 10, 11, 12], // Only specific hours
    minutes: <int>[0, 15, 30, 45], // Quarter-hour intervals
  );
  final RandomDateTime timeRandom =
      RandomDateTime(options: timeConstraintsOptions);
  final DateTime timeConstraintsDateTime = timeRandom.random();
  print('Time-Constrained Random DateTime: $timeConstraintsDateTime\n');

  // Example 5: Generating multiple random DateTimes
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
}
