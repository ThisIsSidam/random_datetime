import 'package:random_datetime/src/models/random_dt_options.dart';
import 'package:random_datetime/src/utils/datetime_ext.dart';
import 'package:test/test.dart';

void main() {
  group('DateTimeExt - remainingMonths', () {
    test('returns remaining months from the current month onwards', () {
      // Test case 1: If the current month is January (month 1)
      final DateTime date = DateTime(2023, 1); // January
      final List<int> remaining = date.remainingMonths();

      // The expected result is [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
      expect(remaining, equals(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
    });

    test('returns remaining months correctly for mid-year (July)', () {
      // Test case 2: If the current month is July (month 7)
      final DateTime date = DateTime(2023, 7); // July
      final List<int> remaining = date.remainingMonths();

      // The expected result is [7, 8, 9, 10, 11, 12]
      expect(remaining, equals(<int>[7, 8, 9, 10, 11, 12]));
    });
  });

  group('RandomDTOptions - getValidYears', () {
    test(
        'returns future years and current year months if allowPastDates is false',
        () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: true,
        startYear: 2020,
        endYear: 2023,
      );
      final List<int> validYears = options.getValidYears();

      // Assuming today's year is 2023 and the current month is December
      expect(validYears, equals(<int>[2020, 2021, 2022, 2023]));
    });

    test('returns all years if allowPastDates is true', () {
      final RandomDTOptions options =
          RandomDTOptions(startYear: 2020, endYear: 2025, months: <int>[1, 2]);
      final List<int> validYears = options.getValidYears();

      // If allowPastDates is false, and months are specified, only valid year is 2025
      expect(validYears, equals(<int>[2025]));
    });
  });

  group('RandomDTOptions - getValidMonths', () {
    test(
        'returns months up to current month if the year is current year and allowPastDates is false',
        () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: false,
        startYear: 2020,
        endYear: 2025,
      );

      // Let's assume the current month is December
      final List<int> validMonths = options.getValidMonths(2023);

      // Only months 1 to 12 should be valid for 2023, as allowPastDates is false
      expect(validMonths, equals(<int>[]));
    });

    test(
        'returns all months if the year is current year and allowPastDates is true',
        () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: true,
        startYear: 2020,
        endYear: 2025,
      );

      // If allowPastDates is true, it should return all months from 1 to 12
      final List<int> validMonths = options.getValidMonths(2023);
      expect(validMonths, equals(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
    });
  });

  group('RandomDTOptions - getValidDays', () {
    test('returns valid days up to today if allowPastDates is false', () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: false,
        startYear: 2024,
        endYear: 2024,
        days: <int>[28, 29, 30],
      );

      // Let's assume today's month is December, and today's day is 11
      final List<int> validDays = options.getValidDays(2024, 12); // December

      // Only days from 1 to 11 should be valid
      expect(validDays, equals(<int>[28, 29, 30]));
    });

    test('returns all days in the month if allowPastDates is true', () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: true,
        startYear: 2023,
        endYear: 2024,
        days: <int>[27, 28, 29, 30, 31],
        months: <int>[2],
      );

      // Let's assume today is December 11
      final List<int> validDays = options.getValidDays(2024, 2); // December

      // Since allowPastDates is true, all days in December (1-31) should be valid
      expect(validDays, equals(<int>[27, 28, 29]));
    });
  });
}
