import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:crux/redux/actions/actions.dart';
import 'package:crux/redux/actions/auth_actions.dart';
import 'package:crux/redux/actions/navigator_action.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/loading_state.dart';
import 'package:crux/redux/routes/routes.dart';
import 'package:crux/redux/services/auth.dart';
import 'package:crux/redux/services/local_storage.dart';

List<Middleware<AppState>> createInitMiddleware(
    AuthService authService,
    // FirestoreService firestoreService,
    LocalStorageService localStorageService) {
  return [
    TypedMiddleware<AppState, InitAppAction>(_init(
        authService,
        // firestoreService,
        localStorageService)),
    // TypedMiddleware<AppState, SubscriptionPositionAction>(_subscriptionPosition(
    //     authService, firestoreService, localStorageService)
  ];
}

Future<void> _noUser(
    Store<AppState> store, LocalStorageService localStorageService) async {
  store.dispatch(LoadingState(isLoading: false, msg: 'Loading...'));
  store.dispatch(NavigatorRootAction(AppRoutes.login));
}

void Function(Store<AppState> store, InitAppAction action, NextDispatcher next)
    _init(
        AuthService authService,
        //  FirestoreService firestoreService,
        LocalStorageService localStorageService) {
  return (store, action, next) async {
    // await localStorageService.clear();
    // store.dispatch(
    //     LoadingStateAction(LoadingState(isLoading: true, msg: 'Loading...')));
    log("run init =======================");

    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      // store.dispatch(
      //     LoadingStateAction(LoadingState(isLoading: true, msg: 'Loading...')));
      if (user == null) {
        log("run user not fiund auth=======================");
        _noUser(store, localStorageService);
      } else {
        log("run user fiund auth=======================");
        store.dispatch(SaveCurrentUserAction(user));
        if (localStorageService.isRegistered)
          store.dispatch(NavigatorPushAction(AppRoutes.home));
        else {
          store.dispatch(NavigatorPushAction(AppRoutes.login));
        }
        //   store.dispatch(NavigatorPushAction(AppRoutes.register_basic));
        // }

      }
    });

    next(action);
  };
}
