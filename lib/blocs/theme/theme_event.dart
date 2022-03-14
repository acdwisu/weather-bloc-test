part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  WeatherChanged(this.condition);
}