import 'package:firebase_auth/firebase_auth.dart';
import 'package:crux/redux/models/app_state.dart';

import 'actions.dart';

class LogoutAction extends AppAction {}

class SaveCurrentUserAction extends AppAction {
  final User user;

  SaveCurrentUserAction(this.user);

  @override
  String toString() => "SaveCurrentUserAction{$user}";
}

class VerifyPhoneNumberAction extends AppAction {
  final String phone;
  final bool isResend;

  VerifyPhoneNumberAction(this.phone, this.isResend);

  @override
  String toString() => "VerifyPhoneNumberAction{$phone}";
}

class SignInWithCredAction extends AppAction {
  final String verificationId;
  final String smsCode;

  SignInWithCredAction(this.verificationId, this.smsCode);

  @override
  String toString() => "SignInWithCredAction{$verificationId, $smsCode}";
}

class OTPSentAction extends AppAction {
  final MyAuth myAuth;

  OTPSentAction(this.myAuth);

  @override
  String toString() => "OTPSentAction{$myAuth}";
}

class ReVerifyPhoneNumberAction extends AppAction {
  final String phone;
  final bool isResend;

  ReVerifyPhoneNumberAction(this.phone, this.isResend);

  @override
  String toString() => "ReVerifyPhoneNumberAction{$phone}";
}

class ChangePhoneAction extends AppAction {
  final String verificationId;
  final String smsCode;

  ChangePhoneAction(this.verificationId, this.smsCode);

  @override
  String toString() => "ChangePhoneAction{$verificationId, $smsCode}";
}
