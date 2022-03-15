import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:logic/logic.dart';
import 'package:shared/shared.dart';

import 'domain/weather/pages/front.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SettingBloc(),
      child: BlocBuilder<SettingBloc, SettingState>(
        buildWhen: (SettingState prevState, SettingState state) {
          bool rebuild = prevState==null || prevState.themeData
              != state.themeData;

          return rebuild;
        },
        builder: (BuildContext ctx, SettingState settingState) {
          return MaterialApp(
            title: 'Weather Bloc Test',
            theme: settingState.themeData,
            home: WeatherFront(
              weatherRepository: WeatherRepository(
                  WeatherProvider(httpClient: Client())
              ),
            ),
          );
        },
      ),
    );
  }
}