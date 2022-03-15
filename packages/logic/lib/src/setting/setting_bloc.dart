import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState(
    temperatureUnit: TemperatureUnit.CELCIUS
  )) {
    on<TemperatureUnitChanged>(_onTemperatureUnitChanged);
    on<WeatherChanged>(_onWeatherChanged);
  }

  void _onTemperatureUnitChanged(
      TemperatureUnitChanged event,
      Emitter<SettingState> emit,
      ) {
    _emitGuard(state.copyWith(
      temperatureUnit: event.newTemperature
    ));
  }

  void _onWeatherChanged(
      WeatherChanged event,
      Emitter<SettingState> emit,
      ) {
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

    _emitGuard(state.copyWith(
      themeData: themeData,
    ));
  }

  void _emitGuard(SettingState settingState) {
    emit.call(settingState);
  }
}
