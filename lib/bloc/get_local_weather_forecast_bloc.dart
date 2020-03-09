import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/models/weather_history.dart';
import 'package:weatherapp/utils/sharedpreference_helper.dart';
import 'package:weatherapp/webservices/repository.dart';

class GetLocalWeatherForeCastBloc {
  var repository = Repository();
  var serviceFetcher = PublishSubject<WeatherHistory>();
  Stream<WeatherHistory> get responseData => serviceFetcher.stream;
  getLocalWeatherForeCast() async {
    ///Get the saved weather data.
    String data = await SharedPreferenceHelper.getForeCastWeather();

    ///Decode the data to json
    if (data != null) {
      String response = json.decode(data);
      var jsonResponse = json.decode(response);

      ///Create model for the Json data.
      WeatherHistory forecastWeather = WeatherHistory.fromJson(jsonResponse);
      serviceFetcher.sink.add(forecastWeather);
    } else
      serviceFetcher.sink.add(null);
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final getLocalWeatherForeCastBloc = GetLocalWeatherForeCastBloc();
