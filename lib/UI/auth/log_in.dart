import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crux/UI/widgets/widget_build_function.dart';
import 'package:crux/redux/actions/actions.dart';
import 'package:crux/redux/actions/auth_actions.dart';
import 'package:crux/redux/middleware/toast_middleware.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/loading_state.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController mobileCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      final Map<String, dynamic> args = {
        "loadingState": store.state.loadingState,
        "showToast": (String msg, ToastCode toastCode) =>
            store.dispatch(ToastAction(msg, toastCode)),
        "signIn": (String mob) async {
          String _phone = "+91" + mob;
          if (mob.isEmpty) {
            store.dispatch(
                ToastAction("Please enter a number", ToastCode.error));
          } else {
            store.dispatch(VerifyPhoneNumberAction(_phone, false));
          }
        },
      };
      return args;
    }, builder: (context, args) {
      final Function signIn = args["signIn"];
      final LoadingState loadingState = args["loadingState"];
      return Scaffold(
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    "assets/img/key.png",
                    width: 220,
                    height: 220,
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Login with your Mobile Number",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 8.0,
                              offset: Offset(5, 5)),
                        ]),
                    height: 200,
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextField(
                            controller: mobileCtrl,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: const InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                prefixIcon: Text("+91"),
                                prefixIconConstraints:
                                    BoxConstraints(minHeight: 0, minWidth: 0)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        //ElevatedButton(onPressed: () {}, child: Text("Continue"))
                        GestureDetector(
                            onTap: () {
                              signIn(mobileCtrl.text);
                            },
                            child: buildButton("Continue"))
                      ],
                    ),
                  )
                ],
              ),
            ),
            loadingIndicator(loadingState)
          ],
        ),
      );
    });
  }
}
