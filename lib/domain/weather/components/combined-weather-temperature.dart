import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic/logic.dart';
import 'package:logic/logic.dart';

import 'temperature.dart';
import 'weather-conditions.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final Weather weather;

  const CombinedWeatherTemperature({
    Key key,
    @required this.weather,
  })
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingBloc>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: WeatherConditions(condition: weather.condition),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder<SettingBloc, SettingState>(
                  bloc: settingsBloc,
                  buildWhen: (SettingState prevState, SettingState state) {
                    bool rebuild = prevState==null || prevState.temperatureUnit
                        != state.temperatureUnit;

                    return rebuild;
                  },
                  builder: (context, state) {
                    return Temperature(
                      temperature: weather.temp,
                      high: weather.maxTemp,
                      low: weather.minTemp,
                      temperatureUnit: state.temperatureUnit,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}