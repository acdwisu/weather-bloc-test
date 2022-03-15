import 'dart:developer';

import 'package:data/data.dart';

class TemperatureUtils {
  num convert(TemperatureUnit sourceUnit, TemperatureUnit destUnit, num value) {
    if(sourceUnit == TemperatureUnit.CELCIUS) {
      if(destUnit == TemperatureUnit.FAHRENHEIT) {
        return (value * 9/5) + 32;
      } else {
        log('not implemented yet');

        return value;
      }
    } else if(sourceUnit == TemperatureUnit.FAHRENHEIT) {
      if(destUnit == TemperatureUnit.CELCIUS) {
        return (value-32) * 5/9;
      } else  {
        log('not implemented yet');

        return value;
      }
    } else {
      log('not implemented yet');

      return value;
    }
  }
}