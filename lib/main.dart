import 'package:flutter/material.dart';
import 'package:weatherapp/screens/current_weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrentaWeatherPage(),
    );
  }
}
