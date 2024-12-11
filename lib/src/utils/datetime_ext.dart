extension DateTimeExt on DateTime {
  /// Returns the number of months remaining in the year
  /// Includes the current month as remaining
  ///
  /// Ex: If the current month is 8, this will return [8, 9, 10, 11, 12]
  List<int> remainingMonths() {
    return List<int>.generate(12 - month + 1, (int index) => month + index);
  }
}
