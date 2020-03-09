import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/bloc/get_current_location_bloc.dart';
import 'package:weatherapp/bloc/get_local_current_weather_bloc.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/weather_forecast_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CurrentaWeatherPage extends StatefulWidget {
  @override
  _CurrentaWeatherPageState createState() => _CurrentaWeatherPageState();
}

class _CurrentaWeatherPageState extends State<CurrentaWeatherPage>
    with WidgetsBindingObserver {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getCurrentLocationBloc.getCurrentLocation(context);
    initializeFirebaseMessaging();
  }

  ///Dispose all the BLoc classes here.
  @override
  void dispose() {
    getCurrentLocationBloc.dispose();
    getLocalCurrentWeatherBloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      getCurrentLocationBloc.getCurrentLocation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new WeatherForeCastPage()));
        },
        child: Icon(Icons.access_time),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/clear.png'), fit: BoxFit.cover),
        ),
        child: StreamBuilder(
            stream: getCurrentLocationBloc.currentLocationObservable,
            builder: (context, AsyncSnapshot<Position> locationSnapshot) {
              if (locationSnapshot.hasData) {
                return StreamBuilder(
                    stream: getLocalCurrentWeatherBloc.responseData,
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
                                '${(weatherSnapshot.data.main.temp - 273.15).toStringAsFixed(0)}°C',
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
                                                '${(weatherSnapshot.data.main.feelsLike - 273.15).toStringAsFixed(0)}°C',
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

  Future<void> initializeFirebaseMessaging() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> msg) async {
        print("onMessage: $msg");
        _showNotification(
            msg['notification']['title'], msg['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> msg) async {
        print("onLaunch: $msg");
        _showNotification(
            msg['notification']['title'], msg['notification']['body']);
      },
      onResume: (Map<String, dynamic> msg) async {
        print("onResume: $msg");
        _showNotification(
            msg['notification']['title'], msg['notification']['body']);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
  }

  ///Show notifications when app is in foreground.
  Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: title);
  }
}
