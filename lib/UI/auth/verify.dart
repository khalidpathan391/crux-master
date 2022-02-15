import 'dart:developer';

import 'package:crux/UI/widgets/widget_build_function.dart';
import 'package:crux/redux/actions/auth_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
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

class VerifyOtpScreen extends StatefulWidget {
  final dynamic prams;
  VerifyOtpScreen(this.prams);
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  void initState() {}
  String otp = "";
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      final Map<String, dynamic> args = {
        "loadingState": store.state.loadingState,
        "navigate": (route) {
          store.dispatch(NavigatorPushAction(route));
        },
        "signIn": () async {
          log("============code===========$otp");
          if (otp == '') {
            store.dispatch(
                ToastAction('Enter the code please', ToastCode.error));
          } else if (otp.length < 6) {
            store.dispatch(ToastAction(
                'Otp should be at least 6 digits.', ToastCode.error));
          } else {
            //SmsAutoFill().unregisterListener();
            store.dispatch(
                SignInWithCredAction(store.state.myAuth.verficationID, otp));
          }
          //
        },
      };
      return args;
    }, builder: (context, args) {
      final Function signIn = args["signIn"];
      final LoadingState loadingState = args["loadingState"];
      String phone = widget.prams[0];
      return Scaffold(
          body: Stack(children: [
        ListView(children: <Widget>[
          const SizedBox(
            height: 70,
          ),
          Image.asset(
            "assets/img/verify.png",
            width: 150,
            height: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Enter OTP Send On Your Mobile Number",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8.0,
                      offset: Offset(5, 5))
                ]),
            height: 220,
            margin: const EdgeInsets.all(25),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Column(children: [
                const SizedBox(
                  height: 10,
                ),
                PinEntryTextField(
                  showFieldAsBox: true,
                  fields: 6,
                  onSubmit: (text) {
                    otp = text as String;
                  },
                ),
              ]),
              const SizedBox(height: 50),
              //ElevatedButton(onPressed: () {}, child: Text("CONTINUE")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("Resend"),
                  GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: buildButton("Continue")),
                ],
              )
            ]),
          ),
        ]),
        loadingIndicator(loadingState),
      ]));
    });
  }
}
