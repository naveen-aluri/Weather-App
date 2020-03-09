import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/get_local_weather_forecast_bloc.dart';
import 'package:weatherapp/bloc/get_weather_history_bloc.dart';
import 'package:weatherapp/models/weather_history.dart';
import 'package:weatherapp/utils/sharedpreference_helper.dart';
import 'package:weatherapp/widgets/forecast_chart.dart';
import 'package:weatherapp/widgets/forecast_list.dart';

class WeatherForeCastPage extends StatefulWidget {
  @override
  _WeatherForeCastPageState createState() => _WeatherForeCastPageState();
}

class _WeatherForeCastPageState extends State<WeatherForeCastPage> {
  @override
  void initState() {
    super.initState();
    getLocalWeatherForeCastBloc.getLocalWeatherForeCast();
    getData();
  }

  @override
  dispose() {
    getLocalWeatherForeCastBloc.dispose();
    super.dispose();
  }

  getData() async {
    double lat = await SharedPreferenceHelper.getLatitude();
    double lng = await SharedPreferenceHelper.getLongitude();
    getWeatherHistoryBloc.getWeatherHistory(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: getLocalWeatherForeCastBloc.responseData,
          builder: (context, AsyncSnapshot<WeatherHistory> snapshot) {
            if (snapshot.hasData)
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Weather and forecast in ${snapshot.data.city.name}, ${snapshot.data.city.country}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: Colors.black54,
                          fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    ForeCastChart(weatherList: snapshot.data.list),
                    SizedBox(height: 20),
                    ForeCastList(weatherList: snapshot.data.list),
                  ],
                ),
              );
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}
