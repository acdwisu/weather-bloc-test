part of 'setting_bloc.dart';

@immutable
class SettingState {
  final TemperatureUnit temperatureUnit;
  final ThemeData themeData;

  SettingState({
    this.temperatureUnit,
    this.themeData,
  });

  SettingState copyWith({
    TemperatureUnit temperatureUnit,
    ThemeData themeData,
  }) {
    return SettingState(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      themeData: themeData ?? this.themeData,
    );
  }
}