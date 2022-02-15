import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:crux/redux/actions/navigator_action.dart';
import 'package:crux/redux/models/app_state.dart';

List<Middleware<AppState>> createNavigationMiddleware(
  GlobalKey<NavigatorState> navigatorKey,
) {
  return [
    TypedMiddleware<AppState, NavigatorPushAction>(_navigate(navigatorKey)),
    TypedMiddleware<AppState, NavigatorReplaceAction>(_replace(navigatorKey)),
    TypedMiddleware<AppState, NavigatorRootAction>(_setRoot(navigatorKey)),
    // TypedMiddleware<AppState, NavigatorPopAction>(_pop(navigatorKey)),

    // TypedMiddleware<AppState, PushDialogAction>(_pushDialog(navigatorKey)),
  ];
}

void Function(
        Store<AppState> store, NavigatorPushAction action, NextDispatcher next)
    _navigate(navigatorKey) {
  return (store, action, next) {
    final route = action.route;
    // log(navigatorKey.currentState.toString());
    if (store.state.routes.last != route) {
      navigatorKey.currentState.pushNamed(route, arguments: action.data);
    }
    next(action);
  };
}

void Function(Store<AppState> store, NavigatorReplaceAction action,
    NextDispatcher next) _replace(GlobalKey<NavigatorState> navigatorKey) {
  return (store, action, next) {
    final String route = action.route;
    navigatorKey.currentState
        .pushReplacementNamed(route, arguments: action.data);
    next(action);
  };
}

// void Function(Store<AppState> store, NavigatorPopAction action, NextDispatcher next)
// _pop(GlobalKey<NavigatorState> navigatorKey) {
// 	return (store, action, next) {
//   	if (navigatorKey.currentState!.canPop()) {
//       navigatorKey.currentState!.pop();
//     }
//     next(action);
//   };
// }

void Function(
        Store<AppState> store, NavigatorRootAction action, NextDispatcher next)
    _setRoot(GlobalKey<NavigatorState> navigatorKey) {
  log(navigatorKey.currentState.toString() + "key  nn");

  return (store, action, next) {
    log(store.state.routes.toString() + "routs");
    final String route = action.route;
    // navigatorKey.currentState.popUntil((route) => false);
    if (store.state.routes.length > 1) {
      navigatorKey.currentState.pushNamedAndRemoveUntil(route, (route) => false,
          arguments: action.data);
    } else {
      navigatorKey.currentState
          .pushReplacementNamed(route, arguments: action.data);
    }
    // else
    //   navigatorKey.currentState.pushReplacementNamed(route, arguments : action.data);

    next(action);
  };
}

// void Function(Store<AppState> store, PushDialogAction action,NextDispatcher next)
// _pushDialog(GlobalKey<NavigatorState> navigatorKey)
// {
// 	return (store, action, next) {
// 		next(action);

// 		// Future<dynamic> dialog = showDialog(
// 		// 	context: action.context ?? navigatorKey.currentContext,
// 		// 	barrierDismissible: action.autoHide ?? true,
// 		// 	builder: action.widgetBuilder,
// 		// );

//     // -----
//     Future<dynamic> dialog = showGeneralDialog(
//       context: action.context ?? navigatorKey.currentContext,
//       pageBuilder: (context, anim1, anim2) {},
//       barrierDismissible: action.autoHide ?? true,
//       barrierColor: Colors.black.withOpacity(0.4),
//       barrierLabel: '',
//       transitionBuilder: (context, anim1, anim2, child) {
//         return FadeTransition(
//           opacity: Tween(begin: 0.0, end: 1.0).animate(anim1),
//                   child: SlideTransition(
//           	position: Tween<Offset>(
//           		begin: const Offset(0.0,1.0),
//           		end: Offset.zero,

//           	).animate(anim1),
//           	child: Builder(builder: action.widgetBuilder),
//              // child is the value returned by pageBuilder
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 600)
//     );
//     // -----

// 		dialog.then((val){
// 			store.dispatch(PoppedDialogAction(dialog));
// 		});

// 		store.dispatch(PushedDialogAction(dialog));
// 	};
// }
