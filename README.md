# Random DateTime

The package provides a simple and customizable way to generate random `DateTime` objects within user-defined bounds. You can control the generation of each unit of time such as years, months, days, hours, minutes, and so on. For example, a randomized datetime between between dates 3 to 5 only.

Although, it can be a bit contradictory that the generation is randomized and yet bounded, it is for those who need it.

## Why?

I was working on my flutter project [Rem](https://github.com/ThisIsSidam/rem-reminds-you) and needed to get randomized dateTime objects. I could have used [Random_Date](https://pub.dev/packages/random_date) but it focused on random dates, and didn't have option to limit time.

## Features

- **Customizable DateTime Units**: Specify custom ranges for years, months, days, hours, minutes, seconds, milliseconds, and microseconds.
- **Option to Allow Past Dates**: Choose whether to allow generating random `DateTime` values from the past.
- **Automatic Filtering**: Automatically filters and ensures valid `DateTime` values based on the current date and the provided ranges.
- **Edge Case Handling**: Handles cases like leap years, month-day mismatches (e.g., February 30), and ensures future or past date generation works smoothly.
- **Error Handling**: If the random generation fails, the plugin retries multiple times before throwing an error.

---

## Installation

To use this plugin, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  random_datetime: ^1.0.0
```

Then, run `pub get` to fetch the package.

---

## Usage

Here is an example of how to use the `random_datetime` package to generate a random `DateTime`:

### Basic Usage

```dart
import 'package:random_datetime/random_datetime.dart';

void main() {
  // Initialize the RandomDateTime with custom options
  final randomDT = RandomDateTime();

  // Generate a random DateTime object
  final randomDateTime = randomDT.random();

  print(randomDateTime);  // Random DateTime
}
```

### Customizing DateTime Range

You can customize the range for each unit of time:

```dart
import 'package:random_datetime/random_datetime.dart';

void main() {
  final options = RandomDTOptions(
    allowPastDates: false, // Disallow generating past dates
    futureYearLimit: 10,   // Limit the future year to 10 years ahead
    startYear: 2000,       // Start year as 2000
    months: [1, 2, 3],     // Only allow months 1 (January), 2 (February), and 3 (March)
    days: [1, 15, 20],     // Only allow specific days of the month
    hours: [9, 15],        // Only allow hours 9 AM and 3 PM
  );

  final randomDT = RandomDateTime(options: options);
  final randomDateTime = randomDT.random();

  print(randomDateTime);  // Random DateTime within the defined range
}
```

---

## API Reference

### `RandomDTOptions`

The `RandomDTOptions` class allows you to define the constraints for each `DateTime` unit:

#### Constructor Parameters

- `allowPastDates`: Whether to allow generating random dates from the past (default is `false`).
- `futureYearLimit`: The maximum number of years into the future that can be generated (default is `5`).
- `startYear`: The starting year for the random `DateTime` range (default is `1970` or the current year depending on `allowPastDates`).
- `endYear`: The ending year for the random `DateTime` range (default is `startYear + futureYearLimit`).
- `months`, `days`, `hours`, `minutes`, `seconds`, `milliseconds`, `microseconds`: Custom lists of values for each unit. If not provided, the default range for each unit is used.

### `RandomDateTime`

The `RandomDateTime` class generates random `DateTime` values based on the provided options.

#### Constructor Parameters

- `options`: An instance of `RandomDTOptions` to define the constraints for the random `DateTime` generation. If not provided, the default `RandomDTOptions` will be used.

#### Methods

- `random()`: Generates and returns a random `DateTime` object based on the options passed to the constructor.

---

## Contributing

We welcome contributions! If you find a bug or want to add a feature, please create an issue or submit a pull request. When submitting a pull request, ensure your changes include appropriate tests.

---

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Thank you for using the `random_datetime` package! I hope it helps.
