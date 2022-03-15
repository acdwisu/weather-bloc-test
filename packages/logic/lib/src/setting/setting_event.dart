part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class TemperatureUnitChanged extends SettingEvent {
  final TemperatureUnit newTemperature;

  TemperatureUnitChanged(this.newTemperature);
}

class WeatherChanged extends SettingEvent {
  final WeatherCondition condition;

  WeatherChanged(this.condition);
}