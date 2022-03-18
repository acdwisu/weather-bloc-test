import 'dart:async';

import 'package:bloc_example/domain/search/components/search-button.dart';
import 'package:bloc_example/domain/setting/components/setting-button.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logic/logic.dart';
import 'package:shared/shared.dart';
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
          SearchButton(
            weatherBloc: weatherBloc,
          ),
          const SettingButton(),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          bloc: weatherBloc,
          listener: (ctx, WeatherState state) {
            if(state is WeatherLoadSuccess) {
              final SettingBloc settingBloc = BlocProvider.of<SettingBloc>(ctx);

              _refreshCompleter.complete(null);

              settingBloc.add(WeatherChanged(state.weather.condition));
            } else if(state is WeatherLoadFail) {
              if(state.weather != null) {
                Fluttertoast.showToast(msg: 'Something went wrong!. Refresh Failed');
              }
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
    return Stack(
      children: [
        const GradientBackground(),
        RefreshIndicator(
          onRefresh: () {
            bloc.add(WeatherRequest(cityName: weather.location));

            return _refreshCompleter.future;
          },
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Location(location: weather.location),
                ),
              ),
              Center(
                child: LastUpdated(dateTime: weather.lastUpdated),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: CombinedWeatherTemperature(
                    weather: weather,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
