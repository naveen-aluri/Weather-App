import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationEnableDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: new Text(
              "Your Location Settings is set to 'Off'.\nPlease enable Location.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Open Settings"),
                onPressed: () {
                  AppSettings.openLocationSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: new Text(
              "Your Location Settings is set to 'Off'.\nPlease enable Location.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Open Settings"),
                onPressed: () {
                  AppSettings.openLocationSettings();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
  }
}
