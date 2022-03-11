import 'package:bloc/bloc.dart';
import 'package:bloc_example/presentation/weather/front.dart';
import 'package:bloc_example/utils/bloc_observer.dart';
import 'package:flutter/material.dart';

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
      home: WeatherFront(),
    );
  }
}