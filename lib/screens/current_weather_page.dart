import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/bloc/get_current_location_bloc.dart';
import 'package:weatherapp/bloc/get_current_weather_bloc.dart';
import 'package:weatherapp/models/weather_model.dart';

class CurrentaWeatherPage extends StatefulWidget {
  @override
  _CurrentaWeatherPageState createState() => _CurrentaWeatherPageState();
}

class _CurrentaWeatherPageState extends State<CurrentaWeatherPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    getCurrentLocationBloc.getCurrentLocation(context);
  }

  ///Dispose all the BLoc classes here.
  @override
  void dispose() {
    getCurrentLocationBloc.dispose();
    getCurrentWeatherBloc.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getCurrentLocationBloc.getCurrentLocation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.access_time),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/strom.png'), fit: BoxFit.cover),
        ),
        child: StreamBuilder(
            stream: getCurrentLocationBloc.currentLocationObservable,
            builder: (context, AsyncSnapshot<Position> locationSnapshot) {
              if (locationSnapshot.hasData) {
                return StreamBuilder(
                    stream: getCurrentWeatherBloc.responseData,
                    builder:
                        (context, AsyncSnapshot<WeatherModel> weatherSnapshot) {
                      if (weatherSnapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${weatherSnapshot.data.name}, ${weatherSnapshot.data.sys.country}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${weatherSnapshot.data.main.temp.toStringAsFixed(0)}°C',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 3,
                                    color: Colors.white,
                                    fontSize: 70),
                              ),
                              Text(
                                '${weatherSnapshot.data.weather[0].main}',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        text: 'HUMIDITY\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                            color: Colors.white,
                                            fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                '${weatherSnapshot.data.main.humidity}%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ]),
                                  ),
                                  SizedBox(width: 20),
                                  RichText(
                                    text: TextSpan(
                                        text: 'FEELS LIKE\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                            color: Colors.white,
                                            fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                '${weatherSnapshot.data.main.feelsLike.toStringAsFixed(1)}°C',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    });
              }

              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }),
      ),
    );
  }
}
