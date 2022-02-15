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

import 'UI/widgets/widget_build_function.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      final Map<String, dynamic> args = {
        "routes": store.state.routes,
        "loadingState": store.state.loadingState,
        "toast": (String msg) {
          store.dispatch(ToastAction(msg, ToastCode.error));
        },
        "navigate": (String route) {
          log("navigation runn====");
          return store.dispatch(NavigatorPushAction(route));
        },
      };
      return args;
    }, builder: (context, args) {
      final LoadingState loadingState = args["loadingState"];
      final Function navigate = args["navigate"];
      final Function toast = args["toast"];
      final List<String> routes = args["routes"];

      return Scaffold(
        backgroundColor: const Color(0xFFEEE6EE),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ListView(
                children: [],
              ),
            )
          ],
        ),
      );
    });
  }
}
