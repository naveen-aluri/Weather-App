import 'package:weatherapp/models/weather_history.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/webservices/api_provider.dart';

class Repository {
  final apiProvider = new ApiProvider();

  Future<WeatherModel> getCurrentWeather(double lat, double lng) =>
      apiProvider.getCurrentWeather(lat, lng);

  Future<WeatherHistory> getWeatherHistory(double lat, double lng) =>
      apiProvider.getWeatherHistory(lat, lng);
}
