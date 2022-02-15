import 'package:crux/UI/ui_constant.dart';
import 'package:crux/UI/widgets/widget_build_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crux/redux/actions/navigator_action.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/loading_state.dart';
import 'package:intl/intl.dart';

class RegisterProfileScreen extends StatefulWidget {
  @override
  _RegisterProfileScreenState createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  String otp = "";
  List<String> universityList = ["LU", "AKTU", "INTEGRAL", "AAPU", "RGMU"];
  List<String> collageList = ["LU", "AKTU", "INTEGRAL", "AAPU", "RGMU"];
  List<String> courseList = ["Sub1", "Sub2", "Sub3", "Sub4", "Sub5"];
  List<String> majorSubList = ["Sub1", "Sub2", "Sub3", "Sub4", "Sub5"];
  List<String> MinerSubList = ["Sub1", "Sub2", "Sub3", "Sub4", "Sub5"];
  bool isStudent;
  String university, collage, course, major1, major2, Miner1, Miner2;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController interstStdCtrl = TextEditingController();
  TextEditingController research1Ctrl = TextEditingController();
  TextEditingController research2Ctrl = TextEditingController();
  TextEditingController experienceCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      final Map<String, dynamic> args = {
        "loadingState": store.state.loadingState,
        "navigate": (route) {
          store.dispatch(NavigatorPushAction(route));
        },
        "register": () async {
          //
        },
      };
      return args;
    }, builder: (context, args) {
      double width = MediaQuery.of(context).size.width - 40;
      final Function register = args["register"];
      final LoadingState loadingState = args["loadingState"];
      return Scaffold(
          body: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * .35,
                  child: Image.asset(
                    "assets/img/student.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  width: width * .6,
                  child: RichText(
                    text: const TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 23),
                        children: [
                          TextSpan(
                              text: "Register",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: " yourself to explore your CRUX")
                        ]),
                  ),
                )
              ],
            ),
            Container(
              decoration:
                  BoxDecoration(border: buildBottomBorder(AppColors.primary)),
              child: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    isStudent = value;
                  });
                },
                hint: Text(
                  "Profile type",
                  style: AppTextStyle.secondary,
                ),
                style: AppTextStyle.secondary,
                underline: const Text(""),
                isExpanded: true,
                value: isStudent,
                items: const [
                  DropdownMenuItem(
                    child: Text("I m a student"),
                    value: true,
                  ),
                  DropdownMenuItem(
                    child: Text("I m a educator"),
                    value: false,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration:
                  BoxDecoration(border: buildBottomBorder(AppColors.primary)),
              child: buildTextField(nameCtrl, "Name"),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration:
                  BoxDecoration(border: buildBottomBorder(AppColors.primary)),
              child: buildTextField(emailCtrl, "Email Id"),
            ),
            Container(
              decoration:
                  BoxDecoration(border: buildBottomBorder(AppColors.primary)),
              child: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      university = value;
                    });
                  },
                  hint: Text(
                    "University/ Institutes",
                    style: AppTextStyle.secondary,
                  ),
                  underline: const Text(""),
                  style: AppTextStyle.secondary,
                  isExpanded: true,
                  value: university,
                  items: universityList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem<String>(
                      child: Text(e),
                      value: e,
                    );
                  }).toList()),
            ),
            Container(
              decoration:
                  BoxDecoration(border: buildBottomBorder(AppColors.primary)),
              child: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      collage = value;
                    });
                  },
                  hint: Text(
                    "Collages",
                    style: AppTextStyle.secondary,
                  ),
                  style: AppTextStyle.secondary,
                  underline: const Text(""),
                  isExpanded: true,
                  value: collage,
                  items: collageList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem<String>(
                      child: Text(e),
                      value: e,
                    );
                  }).toList()),
            ),
            isStudent ?? true
                ? Container(
                    decoration: BoxDecoration(
                        border: buildBottomBorder(AppColors.primary)),
                    child: DropdownButton(
                        onChanged: (value) {
                          setState(() {
                            course = value;
                          });
                        },
                        hint: Text(
                          "Course",
                          style: AppTextStyle.secondary,
                        ),
                        underline: const Text(""),
                        style: AppTextStyle.secondary,
                        isExpanded: true,
                        value: course,
                        items: courseList.map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList()),
                  )
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * .45,
                  decoration: BoxDecoration(
                      border: buildBottomBorder(AppColors.primary)),
                  child: DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          major1 = value;
                        });
                      },
                      hint: Text(
                        "Major Subject",
                        style: AppTextStyle.secondary,
                      ),
                      underline: const Text(""),
                      style: AppTextStyle.secondary,
                      isExpanded: true,
                      value: major1,
                      items: majorSubList.map<DropdownMenuItem<String>>((e) {
                        return DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        );
                      }).toList()),
                ),
                Container(
                  width: width * .45,
                  decoration: BoxDecoration(
                      border: buildBottomBorder(AppColors.primary)),
                  child: DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          major2 = value;
                        });
                      },
                      hint: Text(
                        "Major Subject",
                        style: AppTextStyle.secondary,
                      ),
                      underline: const Text(""),
                      style: AppTextStyle.secondary,
                      isExpanded: true,
                      value: major2,
                      items: majorSubList.map<DropdownMenuItem<String>>((e) {
                        return DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        );
                      }).toList()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * .45,
                  decoration: BoxDecoration(
                      border: buildBottomBorder(AppColors.primary)),
                  child: DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          Miner1 = value;
                        });
                      },
                      hint: Text(
                        "Miner Subject",
                        style: AppTextStyle.secondary,
                      ),
                      underline: const Text(""),
                      style: AppTextStyle.secondary,
                      isExpanded: true,
                      value: Miner1,
                      items: MinerSubList.map<DropdownMenuItem<String>>((e) {
                        return DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        );
                      }).toList()),
                ),
                Container(
                  width: width * .45,
                  decoration: BoxDecoration(
                      border: buildBottomBorder(AppColors.primary)),
                  child: DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          Miner2 = value;
                        });
                      },
                      hint: Text(
                        "Miner Subject",
                        style: AppTextStyle.secondary,
                      ),
                      underline: const Text(""),
                      style: AppTextStyle.secondary,
                      isExpanded: true,
                      value: Miner2,
                      items: MinerSubList.map<DropdownMenuItem<String>>((e) {
                        return DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        );
                      }).toList()),
                ),
              ],
            ),
            isStudent ?? true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * .45,
                        decoration: BoxDecoration(
                            border: buildBottomBorder(AppColors.primary)),
                        child: GestureDetector(
                            onTap: () async {
                              await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now(),
                                firstDate: DateTime(0),
                                errorFormatText: "Out of range",
                              ).then((value) {
                                final DateFormat formatter =
                                    DateFormat('dd-MM-yyyy');
                                final String formatted =
                                    formatter.format(value);
                                setState(() {
                                  dobCtrl.text = formatted;
                                });
                              });
                            },
                            child: buildDobField(dobCtrl, "Date of birth")),
                      ),
                      Container(
                        width: width * .45,
                        decoration: BoxDecoration(
                            border: buildBottomBorder(AppColors.primary)),
                        child:
                            buildTextField(interstStdCtrl, "Interest if any"),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * .45,
                            decoration: BoxDecoration(
                                border: buildBottomBorder(AppColors.primary)),
                            child: buildTextField(
                                research1Ctrl, "Research Interest1"),
                          ),
                          Container(
                            width: width * .45,
                            decoration: BoxDecoration(
                                border: buildBottomBorder(AppColors.primary)),
                            child: buildTextField(
                                research2Ctrl, "Research Interest2"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * .45,
                            decoration: BoxDecoration(
                                border: buildBottomBorder(AppColors.primary)),
                            child: buildTextField(
                                experienceCtrl, "Experience in Years"),
                          ),
                          Container(
                            width: width * .45,
                            decoration: BoxDecoration(
                                border: buildBottomBorder(AppColors.primary)),
                            child: GestureDetector(
                                onTap: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime.now(),
                                    firstDate: DateTime(0),
                                    errorFormatText: "Out of range",
                                  ).then((value) {
                                    final DateFormat formatter =
                                        DateFormat('dd-MM-yyyy');
                                    final String formatted =
                                        formatter.format(value);
                                    setState(() {
                                      dobCtrl.text = formatted;
                                    });
                                  });
                                },
                                child: buildDobField(dobCtrl, "Date of birth")),
                          ),
                        ],
                      ),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                buildButton("Submit"),
              ],
            ),
            loadingIndicator(loadingState)
          ]),
        )
      ]));
    });
  }
}
