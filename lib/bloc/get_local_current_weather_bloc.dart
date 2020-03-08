import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/utils/sharedpreference_helper.dart';
import 'package:weatherapp/webservices/repository.dart';

class GetLocalCurrentWeatherBloc {
  var repository = Repository();
  var serviceFetcher = PublishSubject<WeatherModel>();
  Stream<WeatherModel> get responseData => serviceFetcher.stream;
  getLocalCurrentWeather() async {
    ///Get the saved weather data.
    String data = await SharedPreferenceHelper.getCurrentWeather();

    ///Decode the data to json
    if (data != null) {
      String response = json.decode(data);
      var jsonResponse = json.decode(response);

      ///Create model for the Json data.
      WeatherModel weatherModel = WeatherModel.fromJson(jsonResponse);
      serviceFetcher.sink.add(weatherModel);
    } else
      serviceFetcher.sink.add(null);
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final getLocalCurrentWeatherBloc = GetLocalCurrentWeatherBloc();
