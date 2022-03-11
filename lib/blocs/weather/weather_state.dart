part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoadFail extends WeatherState {
  final String error;
  final Weather weather;

  WeatherLoadFail({this.error, this.weather});
}

class WeatherLoadSuccess extends WeatherState {
  final Weather weather;

  WeatherLoadSuccess({this.weather});
}