import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/bloc/get_local_current_weather_bloc.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/utils/sharedpreference_helper.dart';
import 'package:weatherapp/webservices/repository.dart';

class GetCurrentWeatherBloc {
  var repository = Repository();
  var serviceFetcher = PublishSubject<WeatherModel>();
  Stream<WeatherModel> get responseData => serviceFetcher.stream;
  getCurrentWeather(double lat, double lng) async {
    WeatherModel response = await repository.getCurrentWeather(lat, lng);
    serviceFetcher.sink.add(response);
    if (response != null) {
      ///Convert Weather Model to Map.
      var jsonResponse = weatherModelToJson(response);

      ///Convert Map  to String.
      String data = json.encode(jsonResponse);

      ///Save the String to SharedPreference.
      SharedPreferenceHelper.setCurrentWeather(data);

      ///Call the [Local Current weather Bloc].
      getLocalCurrentWeatherBloc.getLocalCurrentWeather();
    }
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final getCurrentWeatherBloc = GetCurrentWeatherBloc();
