import 'dart:ui';

import 'package:crux/UI/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:crux/redux/models/loading_state.dart';

Widget loadingIndicator(LoadingState loadingState) {
  return loadingState.isLoading
      ? BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset('assets/img/loading.gif'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Text(
                        loadingState.msg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      : const SizedBox();
}

Widget buildBottomIcon(String icon, {double width = 40, double height = 40}) {
  return Image(
    image: AssetImage("assets/img/" + icon),
    height: height,
    width: width,
  );
}

Widget buildButton(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: const TextStyle(color: AppColors.secondary),
    ),
  );
}

Border buildBottomBorder(var color) {
  return Border(
    bottom: BorderSide(
      color: color,
      width: 2,
    ),
  );
}

TextField buildTextField(TextEditingController controller, String lable) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      label: Text(lable),
      border: InputBorder.none,
      labelStyle: AppTextStyle.secondary,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.orange),
      ),
    ),
  );
}

TextField buildDobField(TextEditingController controller, String lable) {
  return TextField(
    controller: controller,
    enabled: false,
    decoration: InputDecoration(
      label: Text(lable),
      border: InputBorder.none,
      labelStyle: AppTextStyle.secondary,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.orange),
      ),
    ),
  );
}
