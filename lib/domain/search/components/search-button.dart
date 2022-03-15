import 'package:bloc_example/domain/search/pages/city-selection.dart';
import 'package:flutter/material.dart';
import 'package:logic/logic.dart';

class SearchButton extends StatelessWidget {
  final WeatherBloc weatherBloc;

  const SearchButton({Key key, this.weatherBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
