import 'package:bloc_example/blocs/weather/weather_bloc.dart';
import 'package:bloc_example/presentation/weather/components/weather.dart';
import 'package:bloc_example/repository/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherFront extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const WeatherFront({Key key, @required this.weatherRepository}) :
      assert(weatherRepository != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (ctx) => WeatherBloc(weatherRepository),
      child: const WeatherContent(),
    );
  }
}
