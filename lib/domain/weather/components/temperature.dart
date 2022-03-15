import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class Temperature extends StatelessWidget {
  final double temperature;
  final double low;
  final double high;
  final TemperatureUnit temperatureUnit;

  final TemperatureUtils _temperatureUtils = TemperatureUtils();

  Temperature({
    Key key,
    this.temperature,
    this.low,
    this.high,
    this.temperatureUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String degreeAbr = temperatureUnit.simplify;

    return Row(
      children: [
        Expanded(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                '${_formattedTemperature(temperature).toStringAsFixed(1)}° $degreeAbr',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'max: ${_formattedTemperature(high).toStringAsFixed(1)}° $degreeAbr',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
            Text(
              'min: ${_formattedTemperature(low).toStringAsFixed(1)}° $degreeAbr',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }

  num _formattedTemperature(double t) => temperatureUnit == TemperatureUnit.CELCIUS?
    t.round() : _temperatureUtils.convert(TemperatureUnit.CELCIUS, TemperatureUnit.FAHRENHEIT, t);
}