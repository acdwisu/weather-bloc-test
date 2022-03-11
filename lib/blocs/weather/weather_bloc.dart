import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/model/weather.dart';
import 'package:bloc_example/repository/weather.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial()) {
    on<WeatherRequest>(_onWeatherRequest);
  }

  void _onWeatherRequest(
    WeatherRequest event,
    Emitter<WeatherState> emit,
  ) async {
    emit.call(WeatherLoading());

    _weatherRepository.getWeather(event.cityName)
    .then((value) {
      emit.call(WeatherLoadSuccess(weather: value));
    })
    .onError((error, stackTrace) {
      _onError(error, stackTrace, emit);
    })
    .timeout(const Duration(seconds: 10), onTimeout: () {
      _onError('Error Timeout', null, emit);
    });
  }

  void _onError(String error, StackTrace trace, Emitter<WeatherState> emit) {
    log(error, stackTrace: trace);

    emit.call(
        WeatherLoadFail(
            error: error,
            weather: _weatherRepository.lastFetchedWeather
        )
    );
  }
}
