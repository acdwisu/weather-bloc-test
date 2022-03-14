import 'package:bloc/bloc.dart';
import 'package:bloc_example/blocs/theme/theme_bloc.dart';
import 'package:bloc_example/presentation/weather/front.dart';
import 'package:bloc_example/provider/weather.dart';
import 'package:bloc_example/repository/weather.dart';
import 'package:bloc_example/utils/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

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
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext ctx2, ThemeState themeState) {
          return MaterialApp(
            title: 'Weather Bloc Test',
            theme: themeState.theme,
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