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
      create: (ctx) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (BuildContext ctx2, ThemeData themeData) {
          return MaterialApp(
            title: 'Weather Bloc Test',
            theme: themeData,
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