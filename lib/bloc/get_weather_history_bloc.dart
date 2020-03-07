import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/models/weather_history.dart';
import 'package:weatherapp/webservices/repository.dart';

class GetWeatherHistoryBloc {
  var repository = Repository();
  var serviceFetcher = PublishSubject<WeatherHistory>();
  Stream<WeatherHistory> get responseData => serviceFetcher.stream;
  getWeatherHistory(double lat, double lng) async {
    WeatherHistory response = await repository.getWeatherHistory(lat, lng);
    serviceFetcher.sink.add(response);
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final getWeatherHistoryBloc = GetWeatherHistoryBloc();
