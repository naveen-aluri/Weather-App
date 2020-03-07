import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSuccessToast(Response response) {
  Fluttertoast.showToast(
      msg: response.data['message'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showSuccessMsg(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showErrorToast(String error) {
  Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
