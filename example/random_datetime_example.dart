import 'package:random_datetime/random_datetime.dart';
import 'package:random_datetime/src/models/range.dart';
import 'package:random_datetime/src/models/range_options.dart';

void main() async {
  final DateTime now = DateTime.now();

  final RandomDateTime randomDT = RandomDateTime(
      options: RandomOptions(
    yearRange: Range(end: now.year + 1),
    dayRange: Range(start: now.day + 3, end: now.day + 14),
    hourRange: const Range(start: 22, end: 10),
  ));

  for (int i = 0; i < 5; i++) {
    // ignore: avoid_print
    print(randomDT.random());
  }
}
