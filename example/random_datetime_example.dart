import 'package:random_datetime/random_datetime.dart';
import 'package:random_datetime/src/models/random_dt_options.dart';

void main() async {
  final DateTime now = DateTime.now();

  final RandomDateTime randomDT = RandomDateTime(
      options: RandomDTOptions(days: <int>[3, 4, 5], endYear: 2025));

  for (int i = 0; i < 5; i++) {
    // ignore: avoid_print
    print(randomDT.random());
  }
}
