import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crux/redux/actions/actions.dart';
import 'package:crux/redux/actions/navigator_action.dart';
import 'package:crux/redux/middleware/toast_middleware.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/evaluate_model.dart';
import 'package:crux/redux/models/loading_state.dart';
import 'package:crux/redux/routes/routes.dart';
import 'dart:convert';
import 'package:crux/redux/services/local_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      final Map<String, dynamic> args = {};
      return args;
    }, builder: (context, args) {
      return Scaffold(
          body: Center(
        child: Image.asset("assets/img/logo.png"),
      ));
    });
  }
}
