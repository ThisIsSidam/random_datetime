import 'package:random_datetime/random_dt_options.dart';
import 'package:random_datetime/src/utils/datetime_ext.dart';
import 'package:test/test.dart';

// ignore_for_file: lines_longer_than_80_chars

// =========== IMPORTANT =========================================
// All tests are written or modified based on the time of it.
// So use your own knowledge to see what should be correct output
// or parameters and test accordingly.
// ================================================================

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
      final RandomDTOptions options = RandomDTOptions(
          startYear: 2020, endYear: 2025, months: <int>[1, 2, 3]);
      final List<int> validYears = options.getValidYears();

      // If allowPastDates is false, and months are specified, only valid year is 2025
      expect(validYears, equals(<int>[2025]));
    });

    test(
        'Does not return current year if only current day is valid. Ignore current day',
        () {
      final RandomDTOptions options =
          RandomDTOptions(startYear: 2024, endYear: 2026, days: <int>[11, 12]);
      final List<int> validYears = options.getValidYears();

      expect(validYears, equals(<int>[2025, 2026]));
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

    test(
        'returns only months left from now in current year if allowPastDates is false',
        () {
      final RandomDTOptions option = RandomDTOptions(
        allowPastDates: false,
        startYear: 2024,
        endYear: 2025,
      );

      final List<int> validMonths = option.getValidMonths(2025);
      expect(
        validMonths,
        equals(<int>[3, 4, 5, 6, 7, 8, 9, 10, 11, 12]),
      ); // change accordingly
    });
  });

  group('RandomDTOptions - getValidDays', () {
    test('returns valid days up to today if allowPastDates is false', () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: false,
        startYear: 2024,
        endYear: 2025,
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

  group('RandomDTOptions - Created through different constructors', () {
    test('Checking both constructors with normal parameters', () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: true,
        startYear: 2023,
        endYear: 2024,
        days: <int>[27, 28, 29, 30, 31],
        months: <int>[2],
      );

      final RandomDTOptions options2 = RandomDTOptions.withRange(
        allowPastDates: true,
        yearRange: TimeRange(start: 2023, end: 2024),
        dayRange: TimeRange(start: 27, end: 31),
        monthRange: TimeRange(start: 2, end: 2),
      );

      expect(options == options2, equals(true));
    });

    test('Checking both constructors with wrapping parameters', () {
      final RandomDTOptions options = RandomDTOptions(
        allowPastDates: true,
        startYear: 2023,
        endYear: 2024,
        months: <int>[11, 12, 1, 2],
        days: <int>[27, 28, 29, 30, 31, 1, 2, 3, 4],
        hours: <int>[22, 23, 0, 1, 2, 3, 4, 5],
        minutes: <int>[58, 59, 0, 1, 2, 3, 4, 5],
      );

      final RandomDTOptions options2 = RandomDTOptions.withRange(
        allowPastDates: true,
        yearRange: TimeRange(start: 2023, end: 2024),
        monthRange: TimeRange(start: 11, end: 2),
        dayRange: TimeRange(start: 27, end: 4),
        hourRange: TimeRange(start: 22, end: 5),
        minuteRange: TimeRange(start: 58, end: 5),
      );

      expect(options == options2, equals(true));
    });
  });
}
