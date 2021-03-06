import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic/logic.dart';

import '../components/weather.dart';

class WeatherFront extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const WeatherFront({Key key, @required this.weatherRepository}) :
      assert(weatherRepository != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (ctx) => WeatherBloc(weatherRepository),
      child: WeatherContent(),
    );
  }
}
