import 'dart:async';
import 'package:bloc_test/my_app.dart';
import 'package:flutter/material.dart';

FutureOr<void> main({String flavor = "prod"}) async {
  runApp( MyApp(flavor: flavor));
}