import 'package:random_datetime/random_datetime.dart';
import 'package:random_datetime/range_options.dart';
import 'package:random_datetime/time_range.dart';

void main() async {
  for (var i = 0; i < 5; i++) {
    print(RandomDateTime(
        options: RandomOptions(
      yearRange: const TimeRange(start: 2028, end: 2030),
    )).random());
  }
}
