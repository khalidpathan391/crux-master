import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crux/UI/auth/verify.dart';
import 'package:crux/UI/splash/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crux/UI/ui_constant.dart';
import 'package:crux/home.dart';
import 'package:crux/redux/actions/actions.dart';
import 'package:crux/redux/middleware/middleware.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/reducers/base_reducer.dart';
import 'package:crux/redux/routes/routes.dart';
import 'package:crux/redux/services/auth.dart';
import 'package:crux/redux/services/local_storage.dart';

import 'UI/auth/log_in.dart';
import 'UI/register/register_profile.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await SmsAutoFill().listenForCode;
  // FirebaseStorage storage = FirebaseStorage.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Store<AppState> store = Store<AppState>(baseReducer,
      initialState: AppState.initial(),
      middleware: createMiddleWare(
        navigatorKey,
        AuthService(auth),
        // FirestoreService(firestore, auth),
        // StorageService(storage, auth),
        LocalStorageService(prefs),
        // HttpService(),
      ));
  store.dispatch(InitAppAction());
  return runApp(crux(store));
  // runApp(const MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: LogInScreen(),
  // ));
}

class crux extends StatelessWidget {
  final Store<AppState> store;

  crux(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: StoreConnector<AppState, Map<String, dynamic>>(
          converter: (store) {
            final Map<String, dynamic> args = {
              // "isloading": store.state.isloading,
              "routes": store.state.routes,
            };
            return args;
          },
          builder: (context, args) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              navigatorObservers: [routeObserver],
              theme: getThemeData(),
              onGenerateRoute: (RouteSettings settings) =>
                  _resolveRoute(settings),
            );
          },
        ));
  }

  PageRoute _resolveRoute(RouteSettings settings) {
    log(settings.name.toString() + "given ");
    if (FirebaseAuth.instance.currentUser != null) {
      switch (settings.name) {
        case AppRoutes.splash:
          return MainRoute(SplashScreen(), settings: settings);
        case AppRoutes.login:
          return MainRoute(LogInScreen(), settings: settings);
          break;
        case AppRoutes.verify:
          return FabRoute(VerifyOtpScreen(settings.arguments),
              settings: settings, duration: 300, direction: 'left');
          break;
        case AppRoutes.registerProfile:
          return FabRoute(RegisterProfileScreen(),
              settings: settings, duration: 300, direction: 'left');
          break;
        case AppRoutes.home:
          return FabRoute(HomeScreen(),
              settings: settings, duration: 300, direction: 'top');
          break;
        default:
          log("default rout");
          return MainRoute(RegisterProfileScreen(), settings: settings);
      }
    }
    switch (settings.name) {
      case AppRoutes.login:
        return MainRoute(LogInScreen(), settings: settings);
        break;
      case AppRoutes.verify:
        return FabRoute(VerifyOtpScreen(settings.arguments),
            settings: settings, duration: 300, direction: 'left');
        break;
      case AppRoutes.registerProfile:
        return FabRoute(RegisterProfileScreen(),
            settings: settings, duration: 300, direction: 'left');
        break;
      case AppRoutes.home:
        return FabRoute(HomeScreen(),
            settings: settings, duration: 300, direction: 'left');
        break;
      default:
        log("default rout");
        return MainRoute(LogInScreen(), settings: settings);
    }
  }
}
