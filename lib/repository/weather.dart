import 'package:bloc_example/model/weather.dart';
import 'package:bloc_example/provider/weather.dart';

class WeatherRepository {
  final WeatherProvider _weatherProvider;

  Weather _lastFetchedWeather;

  WeatherRepository(this._weatherProvider);

  Weather get lastFetchedWeather => _lastFetchedWeather;

  Future<Weather> getWeather(String cityName) async {
    final int locId = await _weatherProvider.getLocationId(cityName);
    final Weather weather = await _weatherProvider.fetchWeather(locId);

    _lastFetchedWeather = weather;

    return weather;
  }
}