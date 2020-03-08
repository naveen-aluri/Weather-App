import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  ///Declare all the keys here.
  static final String latitude = 'latitude';
  static final String longitude = 'longitude';
  static final String currentWeather = 'currentWeather';
  static final String foreCastWeather = 'forecastWeather';

  ///Method that saves the [Latitude].
  static Future<bool> setLatitude(double value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setDouble(latitude, value);
  }

  ///Method that returns the [Latitude].
  static Future<double> getLatitude() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(latitude) ?? null;
  }

  ///Method that saves the [Longitude].
  static Future<bool> setLongitude(double value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setDouble(longitude, value);
  }

  ///Method that returns the [Longitude].
  static Future<double> getLongitude() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(longitude) ?? null;
  }

  ///Method that saves the [CurrentWeather].
  static Future<bool> setCurrentWeather(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(currentWeather, value);
  }

  ///Method that returns the [CurrentWeather].
  static Future<String> getCurrentWeather() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(currentWeather) ?? null;
  }

  ///Method that saves the [ForeCastWeather].
  static Future<bool> setForeCastWeather(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(foreCastWeather, value);
  }

  ///Method that returns the [ForeCastWeather].
  static Future<String> getForeCastWeather() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(foreCastWeather) ?? null;
  }

  static clear() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static remove(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}
