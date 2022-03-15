import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.light()) {
    on<WeatherChanged>(_onWeatherChanged);
  }

  void _onWeatherChanged(
      WeatherChanged event,
      Emitter<ThemeData> emit,
      ) async {
    ThemeData themeData;

    switch(event.condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        themeData = ThemeData(
          primaryColor: Colors.orangeAccent,
        );
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        themeData = ThemeData(
          primaryColor: Colors.lightBlueAccent,
        );
        break;
      case WeatherCondition.heavyCloud:
        themeData = ThemeData(
          primaryColor: Colors.blueGrey,
        );
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        themeData = ThemeData(
          primaryColor: Colors.indigoAccent,
        );
        break;
      case WeatherCondition.thunderstorm:
        themeData = ThemeData(
          primaryColor: Colors.deepPurpleAccent,
        );
        break;
      case WeatherCondition.unknown:
        themeData = ThemeData.light();
        break;
    }

    emit.call(themeData);
  }
}
