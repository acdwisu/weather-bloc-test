import 'package:flutter/foundation.dart';

enum TemperatureUnit {
  CELCIUS, FAHRENHEIT
}

extension TemperatureUnitStringify on TemperatureUnit {
  String get simplify {
    return describeEnum(this).substring(0, 1);
  }
}