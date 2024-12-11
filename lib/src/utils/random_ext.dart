import 'dart:math';

extension RandomExt on Random {
  /// Randomly picks an index count and return the element
  T randomPick<T>(List<T> list) {
    if (list.isEmpty) {
      throw ArgumentError('List cannot be empty');
    }
    final int randomIndex = nextInt(list.length);
    return list[randomIndex];
  }
}
