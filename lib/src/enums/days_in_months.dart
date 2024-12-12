/// An enum that stores how many does a month normally has
/// The enums are named by the name of the months, i.e. all 12 of them
///
/// They have two values
/// - month: The number of the month
/// - _days: The number of days in the month, which is private and accessible
/// through [days] getter or [getDays] method.
enum DaysInMonth {
  january(1, 31),
  february(2, 28),
  march(3, 31),
  april(4, 30),
  may(5, 31),
  june(6, 30),
  july(7, 31),
  august(8, 31),
  september(9, 30),
  october(10, 31),
  november(11, 30),
  december(12, 31),
  ;

  /// Constructs a [DaysInMonth] instance
  const DaysInMonth(this.month, this._days);

  /// The number of the month. Starts with 1, i.e. january
  final int month;

  /// The number of days normally present in the month.
  /// Accessible through [days] getter and [getDays] method.
  final int _days;

  /// Getter for the number of days present in the month
  /// Does not check for leap year hence for february the number
  /// of days will always be 28.
  int get days => _days;

  /// Returns the number of days in the month
  /// It takes the year as an optional parameter
  ///
  /// If the month is february, it checks if it is a leap year or not.
  /// If [year] is null, it uses the current year as default.
  int getDays({int? year}) {
    if (month == 2) {
      final bool isLeap = isLeapYear(year ?? DateTime.now().year);
      if (isLeap) {
        return _days + 1;
      }
      return _days;
    }
    return _days;
  }

  /// Returns the number of days in the month from its number
  /// It takes the year as an optional parameter to check for leap
  /// years in [getDays] method.
  static int daysCountFromNumber(int month, {int? year}) {
    return DaysInMonth.values[month - 1].getDays(year: year);
  }
}

/// A method to check whether the passed year is leap year or not.
bool isLeapYear(int year) {
  if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
    return true;
  } else {
    return false;
  }
}
