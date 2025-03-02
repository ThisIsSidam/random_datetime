## 0.0.1

* Added basic implementation of the RandomDateTime class. It uses Ranges as input.

## 0.0.2

* No important changes. I fixed file structure and other minor things.

## 1.0.0

* Added option to get DateTime objects of past.
* Added option to change the future years default count (was 5 previously).
* Removed Ranges for RandomDTOptions and added list input for more specifity.
* Added proper documentations for all classes and methods.
* Added various tests and fixed issues.

## 1.0.1

* Moved 'test' package to dev-dependency so it doesn't conflict when being used.

## 1.0.2

* Made DaysInMonths enum accessible
* Changed License to MIT

## 1.0.3

* Added RandomDTOptions.withRange constructor
* Added proper error throw for in case valid year was not found

## 1.0.4

* Fixed Error in valid year and month selection
* Fixed the three-try random generation in .random method