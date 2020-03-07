// To parse this JSON data, do
//
//     final weatherHistory = weatherHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:weatherapp/models/weather_model.dart';

WeatherHistory weatherHistoryFromJson(String str) =>
    WeatherHistory.fromJson(json.decode(str));

String weatherHistoryToJson(WeatherHistory data) => json.encode(data.toJson());

class WeatherHistory {
  City city;
  String cod;
  double message;
  int cnt;
  List<ListElement> list;

  WeatherHistory({
    this.city,
    this.cod,
    this.message,
    this.cnt,
    this.list,
  });

  factory WeatherHistory.fromJson(Map<String, dynamic> json) => WeatherHistory(
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        cod: json["cod"] == null ? null : json["cod"],
        message: json["message"] == null ? null : json["message"].toDouble(),
        cnt: json["cnt"] == null ? null : json["cnt"],
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city.toJson(),
        "cod": cod == null ? null : cod,
        "message": message == null ? null : message,
        "cnt": cnt == null ? null : cnt,
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        country: json["country"] == null ? null : json["country"],
        population: json["population"] == null ? null : json["population"],
        timezone: json["timezone"] == null ? null : json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "coord": coord == null ? null : coord.toJson(),
        "country": country == null ? null : country,
        "population": population == null ? null : population,
        "timezone": timezone == null ? null : timezone,
      };
}

class ListElement {
  int dt;
  int sunrise;
  int sunset;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  List<Weather> weather;
  double speed;
  int deg;
  int clouds;
  double rain;

  ListElement({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.weather,
    this.speed,
    this.deg,
    this.clouds,
    this.rain,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"] == null ? null : json["dt"],
        sunrise: json["sunrise"] == null ? null : json["sunrise"],
        sunset: json["sunset"] == null ? null : json["sunset"],
        temp: json["temp"] == null ? null : Temp.fromJson(json["temp"]),
        feelsLike: json["feels_like"] == null
            ? null
            : FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"] == null ? null : json["pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        weather: json["weather"] == null
            ? null
            : List<Weather>.from(
                json["weather"].map((x) => Weather.fromJson(x))),
        speed: json["speed"] == null ? null : json["speed"].toDouble(),
        deg: json["deg"] == null ? null : json["deg"],
        clouds: json["clouds"] == null ? null : json["clouds"],
        rain: json["rain"] == null ? null : json["rain"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt == null ? null : dt,
        "sunrise": sunrise == null ? null : sunrise,
        "sunset": sunset == null ? null : sunset,
        "temp": temp == null ? null : temp.toJson(),
        "feels_like": feelsLike == null ? null : feelsLike.toJson(),
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "weather": weather == null
            ? null
            : List<dynamic>.from(weather.map((x) => x.toJson())),
        "speed": speed == null ? null : speed,
        "deg": deg == null ? null : deg,
        "clouds": clouds == null ? null : clouds,
        "rain": rain == null ? null : rain,
      };
}

class FeelsLike {
  double day;
  double night;
  double eve;
  double morn;

  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"] == null ? null : json["day"].toDouble(),
        night: json["night"] == null ? null : json["night"].toDouble(),
        eve: json["eve"] == null ? null : json["eve"].toDouble(),
        morn: json["morn"] == null ? null : json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "night": night == null ? null : night,
        "eve": eve == null ? null : eve,
        "morn": morn == null ? null : morn,
      };
}

class Temp {
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"] == null ? null : json["day"].toDouble(),
        min: json["min"] == null ? null : json["min"].toDouble(),
        max: json["max"] == null ? null : json["max"].toDouble(),
        night: json["night"] == null ? null : json["night"].toDouble(),
        eve: json["eve"] == null ? null : json["eve"].toDouble(),
        morn: json["morn"] == null ? null : json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "min": min == null ? null : min,
        "max": max == null ? null : max,
        "night": night == null ? null : night,
        "eve": eve == null ? null : eve,
        "morn": morn == null ? null : morn,
      };
}
