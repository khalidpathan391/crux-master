import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:crux/UI/ui_constant.dart';
import 'package:crux/redux/actions/actions.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/loading_state.dart';

enum ToastCode { alert, error, notice }

List<Middleware<AppState>> createToastMiddleware() {
  return [
    TypedMiddleware<AppState, ToastAction>(_toastAction()),
    TypedMiddleware<AppState, LoadingStateAction>(_loadingStateAction()),
  ];
}

void Function(Store<AppState> store, ToastAction action, NextDispatcher next)
    _toastAction() {
  return (store, action, next) async {
    log('===========Fluttertoast=============');
    // log('Fluttertoast : ' + action.message);
    // log('---------------------------------');
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: action.message,
      backgroundColor: action.toastCode == ToastCode.error
          ? Colors.red
          : action.toastCode == ToastCode.alert
              ? AppColors.primary
              : AppColors.heading,
      textColor: action.toastCode == ToastCode.error
          ? Colors.white
          : action.toastCode == ToastCode.alert
              ? Colors.black
              : Colors.black,
    );

    next(action);
  };
}

void Function(
        Store<AppState> store, LoadingStateAction action, NextDispatcher next)
    _loadingStateAction() {
  return (store, action, next) async {
    store.state.copyWith(newLoadingState: action.loadingState);
    next(action);
  };
}
