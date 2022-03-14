import 'package:bloc_example/blocs/weather/weather_bloc.dart';
import 'package:bloc_example/model/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'city-selection.dart';
import 'combined-weather-temperature.dart';
import 'last-updated.dart';
import 'location.dart';

class WeatherContent extends StatelessWidget {
  const WeatherContent({Key key}) : super(key: key);

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
        child: BlocBuilder<WeatherBloc, WeatherState>(
          bloc: weatherBloc,
          builder: (ctx, WeatherState state) {


            if(state is WeatherInitial) {
              return Center(child: Text('Please Select a Location'));
            }
            else if(state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            else if(state is WeatherLoadSuccess) {
              final weather = state.weather;

              return _weatherView(weather);
            }
            else if(state is WeatherLoadFail) {
              if(state.weather == null) {
                return Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return _weatherView(state.weather);
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

  Widget _weatherView(Weather weather) {
    return ListView(
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
    );
  }
}
