import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:crux/redux/models/error.dart';

class AuthService {
  final FirebaseAuth auth;
  AuthService(this.auth);
  Future<UserCredential> signInWithCredAction(
      String vID, String smsCode) async {
    UserCredential userCredential;
    try {
      userCredential = await auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: vID, smsCode: smsCode),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'account-exists-with-different-credential') {
        throw MyError(
            code: 'FirebaseAuthException',
            msg: 'The account already exists with a different credential.',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      } else if (e.code == 'invalid-credential') {
        throw MyError(
            code: 'FirebaseAuthException',
            msg: 'Error occurred while accessing credentials. Try again.',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      } else if (e.code == 'operation-not-allowed') {
        throw MyError(
            code: 'FirebaseAuthException',
            msg: 'Error occurred while accessing credentials. Try again.',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      } else if (e.code == 'user-disabled') {
        throw MyError(
            code: 'FirebaseAuthException',
            msg: 'Account disabled',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      } else if (e.code == 'invalid-verification-code') {
        throw MyError(
            code: 'FirebaseAuthException',
            msg: 'The entered verification code is incorrect. Try again.',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      } else if (e.code == 'invalid-verification-id') {
        throw MyError(
            code: 'FirebaseAuthException',
            msg: 'The verification ID is not valid. Try again.',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      } else if (e.code == 'session-expired') {
        throw MyError(
            code: 'session-expired',
            msg:
                'The SMS code has expired. Please re-send the verification code to try again.',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      } else if (e.code == 'network-request-failed') {
        throw MyError(
            code: 'network-request-failed',
            msg: 'Unable to connect to internet.',
            errorMsg: e.toString(),
            location: 'services/Auth.dart');
      }
    } on PlatformException catch (e) {
      // log("PlatformException : " + e.code);
      throw MyError(
          code: 'PlatformException',
          msg: 'Please check internet connection and try again.',
          errorMsg: e.toString(),
          location: 'services/Auth.dart');
    } on SocketException catch (e) {
      throw MyError(
          code: 'SocketException',
          msg: 'Please check internet connection and try again.',
          errorMsg: e.toString(),
          location: 'services/Auth.dart');
    } on TimeoutException catch (e) {
      throw MyError(
          code: 'TimeoutException',
          msg: 'Timeout! Please try again.',
          errorMsg: e.toString(),
          location: 'services/Auth.dart');
    } catch (e) {
      log('1 : ' + e.toString());
      throw MyError(
          code: 'Other',
          msg: 'Something went wrong. Please try again.',
          errorMsg: e.toString(),
          location: 'services/Auth.dart');
    }
  }
}
