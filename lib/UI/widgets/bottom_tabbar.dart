// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crux/redux/actions/navigator_action.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/loading_state.dart';
import 'package:crux/redux/routes/routes.dart';

class BottomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      final Map<String, dynamic> args = {
        "routes": store.state.routes,
        "isLoading": store.state.loadingState,
        "navigate": (String route) {
          List<String> routes = store.state.routes;
          if (routes.last != route)
            return store.dispatch(NavigatorReplaceAction(route));
        },
      };
      return args;
    }, builder: (context, args) {
      final LoadingState loading = args["isLoading"];
      final Function navigate = args["navigate"];
      final List<String> routes = args["routes"];
      // log("routes : " + routes.toString());

      return BottomAppBar(
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: routes.first == AppRoutes.home ? 0 : 1,
          onTap: loading.isLoading
              ? null
              : (int i) {
                  if (loading.isLoading) return;
                  if (i == 0) {
                    String route = AppRoutes.home;
                    navigate(route);
                  } else {
                    // String route = AppRoutes.profile;
                    //navigate(route);
                  }
                },
          items: [
            new BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            new BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
          ],
        ),
      );
    });
  }
}
