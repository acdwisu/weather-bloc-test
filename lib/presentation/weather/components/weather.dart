import 'dart:async';
import 'dart:developer';

import 'package:bloc_example/blocs/theme/theme_bloc.dart';
import 'package:bloc_example/blocs/weather/weather_bloc.dart';
import 'package:bloc_example/model/weather.dart';
import 'package:bloc_example/utils/gradient-container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'city-selection.dart';
import 'combined-weather-temperature.dart';
import 'last-updated.dart';
import 'location.dart';

class WeatherContent extends StatelessWidget {
  Completer<void> _refreshCompleter = Completer<void>();

  WeatherContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                weatherBloc.add(WeatherRequest(cityName: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          bloc: weatherBloc,
          listener: (ctx, WeatherState state) {
            if(state is WeatherLoadSuccess) {
              final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(ctx);

              themeBloc.add(WeatherChanged(state.weather.condition));
            }
          },
          builder: (ctx, WeatherState state) {
            if (state is WeatherInitial) {
              return const Center(child: Text('Please Select a Location'));
            }
            else if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is WeatherLoadSuccess) {
              final weather = state.weather;

              _refreshCompleter?.complete();
              _refreshCompleter = Completer();

              return _weatherView(weather, weatherBloc);
            }
            else if (state is WeatherLoadFail) {
              if (state.weather == null) {
                return const Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return _weatherView(state.weather, weatherBloc);
              }
            }
            else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _weatherView(Weather weather, WeatherBloc bloc) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return GradientContainer(
          color: state.color,
          child: RefreshIndicator(
            onRefresh: () {
              bloc.add(WeatherRequest(cityName: weather.location));

              return _refreshCompleter.future;
            },
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: Location(location: weather.location),
                  ),
                ),
                Center(
                  child: LastUpdated(dateTime: weather.lastUpdated),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Center(
                    child: CombinedWeatherTemperature(
                      weather: weather,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
