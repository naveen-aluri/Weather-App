import 'package:flutter/material.dart';

class CurrentaWeatherPage extends StatefulWidget {
  @override
  _CurrentaWeatherPageState createState() => _CurrentaWeatherPageState();
}

class _CurrentaWeatherPageState extends State<CurrentaWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(title: Text('Weather')),
        body: Container(),
      ),
    );
  }
}
