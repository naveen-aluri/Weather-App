import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/bloc/get_local_weather_forecast_bloc.dart';
import 'package:weatherapp/models/weather_history.dart';
import 'package:weatherapp/utils/sharedpreference_helper.dart';
import 'package:weatherapp/webservices/repository.dart';

class GetWeatherHistoryBloc {
  var repository = Repository();
  var serviceFetcher = PublishSubject<WeatherHistory>();
  Stream<WeatherHistory> get responseData => serviceFetcher.stream;
  getWeatherHistory(double lat, double lng) async {
    WeatherHistory response = await repository.getWeatherHistory(lat, lng);
    serviceFetcher.sink.add(response);
    if (response != null) {
      ///Convert Weather History to Map.
      var jsonResponse = weatherHistoryToJson(response);

      ///Convert Map  to String.
      String data = json.encode(jsonResponse);

      ///Save the String to SharedPreference.
      SharedPreferenceHelper.setForeCastWeather(data);

      ///Call the [Local ForeCast weather Bloc].
      getLocalWeatherForeCastBloc.getLocalWeatherForeCast();
    }
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final getWeatherHistoryBloc = GetWeatherHistoryBloc();
