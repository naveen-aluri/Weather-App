import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/dialogs/location_dialog.dart';
import 'package:weatherapp/utils/sharedpreference_helper.dart';

class GetCurrentLocationBloc {
  Geolocator geolocator = Geolocator();
  Position userLocation;
  BehaviorSubject<Position> behaviorSubject;

  GetCurrentLocationBloc() {
    behaviorSubject = new BehaviorSubject<Position>.seeded(userLocation);
  }

  Stream<Position> get currentLocationObservable => behaviorSubject.stream;

  getCurrentLocation(BuildContext context) async {
    Position currentLocation;
    await geolocator.isLocationServiceEnabled().then((isEnabled) async {
      if (isEnabled) {
        try {
          currentLocation = await geolocator.getLastKnownPosition(
              desiredAccuracy: LocationAccuracy.high);
          print("Last Location: $currentLocation");
          if (currentLocation == null)
            currentLocation = await geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);

          if (currentLocation != null) {
            SharedPreferenceHelper.setLatitude(currentLocation.latitude);
            SharedPreferenceHelper.setLongitude(currentLocation.longitude);
          }
          behaviorSubject.sink.add(currentLocation);
        } catch (e) {
          currentLocation = null;
        }
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return LocationEnableDialog();
            });
      }
    });
  }

  void dispose() {
    behaviorSubject.close();
  }
}

final getCurrentLocationBloc = GetCurrentLocationBloc();
