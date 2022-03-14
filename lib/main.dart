import 'package:bloc/bloc.dart';
import 'package:bloc_example/presentation/weather/front.dart';
import 'package:bloc_example/provider/weather.dart';
import 'package:bloc_example/repository/weather.dart';
import 'package:bloc_example/utils/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherFront(
        weatherRepository: WeatherRepository(
            WeatherProvider(httpClient: Client())
        ),
      ),
    );
  }
}