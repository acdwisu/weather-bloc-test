import 'package:flutter/material.dart';

class WeatherFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  border: OutlineInputBorder(),
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/images/sun.png",
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "New York",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "38",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Get Weather"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
