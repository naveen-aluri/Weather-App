import 'package:dio/dio.dart';
import 'package:weatherapp/models/weather_history.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/utils/constants.dart';

import 'api_error_handler.dart';
import 'api_manager.dart';

class ApiProvider {
  ///API to get the current weather details.
  Future<WeatherModel> getCurrentWeather(double lat, double lng) async {
    try {
      Response response = await ApiManager.dio()
          .get('/data/2.5/weather?lat=$lat&lon=$lng&appid=${Constants.apiKey}');

      return WeatherModel.fromJson(response.data);
    } on DioError catch (e) {
      displayErrorMsg(e);
      return null;
    }
  }

  ///API to get the past 16 days Weather History.
  Future<WeatherHistory> getWeatherHistory(double lat, double lng) async {
    try {
      Response response = await ApiManager.dio().get(
          '/data/2.5/forecast/daily?lat=$lat&lon=$lng&appid=${Constants.apiKey}&cnt=17');
      return WeatherHistory.fromJson(response.data);
    } on DioError catch (e) {
      displayErrorMsg(e);
      return null;
    }
  }
}
