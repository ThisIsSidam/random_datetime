import 'package:random_datetime/random_datetime.dart';
import 'package:random_datetime/range.dart';
import 'package:random_datetime/range_options.dart';

void main() async {
  final now = DateTime.now();

  final RandomDateTime randomDT = RandomDateTime(
      options: RandomOptions(
    yearRange: Range(end: now.year + 1),
    dayRange: Range(start: now.day + 3, end: now.day + 14),
    hourRange: const Range(start: 22, end: 10),
  ));

  for (var i = 0; i < 5; i++) {
    print(randomDT.random());
  }
}
