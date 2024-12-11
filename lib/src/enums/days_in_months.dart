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

  const DaysInMonth(this.month, this._days);
  final int month;
  final int _days;

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

  static int daysCountFromNumber(int month, {int? year}) {
    return DaysInMonth.values[month - 1].getDays(year: year);
  }
}

bool isLeapYear(int year) {
  if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
    return true;
  } else {
    return false;
  }
}
