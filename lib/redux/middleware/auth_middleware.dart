import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:crux/constraints/constraints.dart';
import 'package:crux/redux/actions/actions.dart';
import 'package:crux/redux/actions/auth_actions.dart';
import 'package:crux/redux/actions/navigator_action.dart';
import 'package:crux/redux/middleware/toast_middleware.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/error.dart';
import 'package:crux/redux/models/loading_state.dart';
import 'package:crux/redux/routes/routes.dart';
import 'package:crux/redux/services/auth.dart';
import 'package:crux/redux/services/local_storage.dart';

List<Middleware<AppState>> createAuthMiddleware(
  AuthService authService,
  LocalStorageService localStorageService,
  // FirestoreService firestoreService,
  // AmplitudeService amplitudeService
) {
  return [
    // TypedMiddleware<AppState, LogoutAction>(
    //     _logout(authService, amplitudeService, localStorageService)),
    TypedMiddleware<AppState, VerifyPhoneNumberAction>(
        _verifyPhoneNumber(authService)),
    TypedMiddleware<AppState, SignInWithCredAction>(
        _signInWithCred(authService, localStorageService
            // firestoreService,
            //  amplitudeService
            )),
    // TypedMiddleware<AppState, ReVerifyPhoneNumberAction>(
    //     _reverifyPhoneNumber(authService)),
    // TypedMiddleware<AppState, ChangePhoneAction>(
    //     _changePhone(authService, amplitudeService)),
  ];
}

void Function(Store<AppState> store, VerifyPhoneNumberAction action,
    NextDispatcher next) _verifyPhoneNumber(AuthService authService) {
  return (store, action, next) async {
    // store.dispatch(AmplitudeAction(
    //     event: 'Verifing Phone Number',
    //     eventProperties: {'phone': action.phone, 'isResend': action.isResend}));

    store.dispatch(
        LoadingStateAction(LoadingState(isLoading: true, msg: 'verifying...')));
    log("code run:=============" + action.phone + "mobile");
    authService.auth
        .verifyPhoneNumber(
      phoneNumber: action.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // store.dispatch(AmplitudeAction(event: 'verified', eventProperties: {
        //   'phone': action.phone,
        //   'isResend': action.isResend
        // }));
      },
      verificationFailed: (FirebaseAuthException e) async {
        log("verigication failed===============");
        if (e.code == 'network-request-failed')
          store
              .dispatch(ToastAction('No internet connection', ToastCode.error));
        else
          store.dispatch(ToastAction(e.message, ToastCode.error));

        // store.dispatch(AmplitudeAction(
        //     event: 'verificationFailed Error',
        //     eventProperties: {'error': e.toString()}));
        store.dispatch(
            LoadingStateAction(LoadingState(isLoading: false, msg: '')));
      },
      codeSent: (String _verficationID, int resendToken) async {
        log("code send:=============");
        store.dispatch(ToastAction("Otp sent", ToastCode.error));
        if (!action.isResend) {
          log("code send if false:=============");
          store.dispatch(OTPSentAction(
              MyAuth(otpSent: true, verficationID: _verficationID)));
          store.dispatch(
              LoadingStateAction(LoadingState(isLoading: false, msg: '')));
          store.dispatch(
              NavigatorPushAction(AppRoutes.verify, data: [action.phone]));
          // store.dispatch(AmplitudeAction(event: 'OTP Sent', eventProperties: {
          //   'phone': action.phone,
          //   'isResend': action.isResend
          // }));
        } else {
          log("code send else part:=============");
          store.dispatch(
              LoadingStateAction(LoadingState(isLoading: false, msg: '')));
          // store.dispatch(AmplitudeAction(event: 'OTP Resent', eventProperties: {
          //   'phone': action.phone,
          //   'isResend': action.isResend
          // }));
        }
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        log("retrivel time out==========");
        store.dispatch(
            LoadingStateAction(LoadingState(isLoading: false, msg: '')));
        //store.dispatch(ToastAction('Timed out', ToastCode.error));
      },
      timeout: Duration(seconds: 25),
    )
        .timeout(timeoutDuration, onTimeout: () {
      store.dispatch(
          LoadingStateAction(LoadingState(isLoading: false, msg: '')));
      store.dispatch(ToastAction('Timed out', ToastCode.error));
    });
    next(action);
  };
}

void Function(Store<AppState> store, SignInWithCredAction, NextDispatcher next)
    _signInWithCred(
  AuthService authService,
  LocalStorageService localStorageService,
  //  FirestoreService firestoreService,
  // AmplitudeService amplitudeService
) {
  return (store, action, next) async {
    // store.dispatch(AmplitudeAction(event: 'Signing in', eventProperties: {}));
    store.dispatch(LoadingStateAction(
        LoadingState(isLoading: true, msg: 'Signing in...')));

    UserCredential userCredential;

    try {
      userCredential = await authService.signInWithCredAction(
          action.verificationId, action.smsCode);
      if (userCredential.user != null) {
        store.dispatch(SaveCurrentUserAction(userCredential.user));
        // store
        //     .dispatch(AmplitudeAction(event: 'Signed Up', eventProperties: {}));
        store.dispatch(LoadingStateAction(
            LoadingState(isLoading: false, msg: 'Signing in...')));
        store
            .dispatch(OTPSentAction(MyAuth(otpSent: false, verficationID: "")));
        store.dispatch(ToastAction("Verified success", ToastCode.error));
        store.dispatch(NavigatorRootAction(AppRoutes.registerProfile));
      }
    } on MyError catch (e) {
      store.dispatch(ToastAction(
        e.msg,
        ToastCode.error,
      ));

      if (e.code == 'session-expired') {
        store.dispatch(NavigatorRootAction(AppRoutes.login));
      }

      // store.dispatch(
      //     AmplitudeAction(event: 'SignIn Error', eventProperties: e.toJson()));
      store.dispatch(LoadingStateAction(
          LoadingState(isLoading: false, msg: 'Signing in...')));
    }

    next(action);
  };
}
