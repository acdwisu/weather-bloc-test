import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
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

    await _weatherRepository.getWeather(event.cityName)
    .then((value) {
      emit.call(WeatherLoadSuccess(weather: value));
    })
    .onError((error, stackTrace) {
      _onError(error.toString(), stackTrace, emit, event);
    })
    .timeout(const Duration(seconds: 10), onTimeout: () {
      _onError('Error Timeout', null, emit, event);
    });
  }

  void _onError(String error, StackTrace trace, Emitter<WeatherState> emit, WeatherRequest event) {
    log(error, stackTrace: trace);

    emit.call(
        WeatherLoadFail(
            error: error,
            weather: event.cityName==_weatherRepository.lastFetchedWeather.location?
              _weatherRepository.lastFetchedWeather : null,
        )
    );
  }
}
