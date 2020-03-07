import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/webservices/repository.dart';

class GetCurrentWeatherBloc {
  var repository = Repository();
  var serviceFetcher = PublishSubject<WeatherModel>();
  Stream<WeatherModel> get responseData => serviceFetcher.stream;
  getCurrentWeather(double lat, double lng) async {
    WeatherModel response = await repository.getCurrentWeather(lat, lng);
    serviceFetcher.sink.add(response);
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final getCurrentWeatherBloc = GetCurrentWeatherBloc();
