import 'package:flutter/material.dart';

ThemeData getThemeData() {
  return ThemeData(
    primaryColor: AppColors.primary,
    //canvasColor: Colors.black,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        onPrimary: Colors.black,
        textStyle: TextStyle(letterSpacing: 1),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        // color: Colors.white,
        elevation: 0),
    checkboxTheme: CheckboxThemeData(fillColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primary; // the color when checkbox is selected;
        }
        return Colors.white; //the color when checkbox is unselected;
      },
    )),
    bottomAppBarColor: Colors.black,
    // buttonColor: AppColors.primary,
    // buttonTheme: ButtonThemeData(
    //   buttonColor: AppColors.primary
    // )
    // bottomAppBarTheme: BottomAppBarTheme(elevation: 0),
    // tabBarTheme: TabBarTheme(labelPadding: EdgeInsets.zero)
  );
}

MaterialColor createSwatch(int r, int g, int b, double o) {
  Map<int, Color> swatch = {};
  List<int> opacities = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  for (int opacity in opacities)
    swatch[opacity] = Color.fromRGBO(r, g, b, opacity / 1000);
  return MaterialColor(Color.fromRGBO(r, g, b, o).value, swatch);
}

// Color a = Color(0xFF8e9495).withOpacity(0.5);

// class AppColors {
//   static final MaterialColor primary = createSwatch(217, 232, 171, 1);
//   static final MaterialColor text = createSwatch(175, 167, 155, 1);
//   static final MaterialColor heading = createSwatch(237, 222, 204, 1);
//   static final MaterialColor highLight = createSwatch(193, 64, 64, 1);
//   static final MaterialColor canvas = createSwatch(0, 0, 0, 1);
//   static final MaterialColor menu = createSwatch(34, 34, 34, 1);
// }
class AppColors {
  static const primary = Color(0xFFF19122);
  static const secondary = Color(0xFF06CAC0);
  static final MaterialColor heading = createSwatch(237, 222, 204, 1);
  static final MaterialColor highLight = createSwatch(193, 64, 64, 1);
  static final MaterialColor canvas = createSwatch(0, 0, 0, 1);
  static final MaterialColor menu = createSwatch(34, 34, 34, 1);
}

/// TextStyle - common
class AppTextStyle {
  static TextStyle secondary = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 17,
    color: AppColors.secondary,
  );
  static TextStyle subHeading = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 13,
      color: AppColors.heading,
      fontWeight: FontWeight.w700,
      letterSpacing: 1);
  static final TextStyle text = TextStyle(
      fontSize: 13, fontFamily: 'Montserrat', color: AppColors.secondary);
  static final TextStyle labelTextStyle = TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
      color: AppColors.heading,
      letterSpacing: 1,
      fontSize: 12);
  static final TextStyle skip =
      TextStyle(color: AppColors.primary, fontWeight: FontWeight.w400);
  static final TextStyle listText =
      TextStyle(color: AppColors.heading, fontWeight: FontWeight.w500);
  static final TextStyle textField = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.heading);

  static final TextStyle hint = TextStyle(
      fontWeight: FontWeight.w500, color: createSwatch(143, 148, 149, 1));

  // static final TextStyle pageHeaderTextStyle = TextStyle(fontSize:22,fontWeight: FontWeight.w700,color: Colors.black);
  // static final TextStyle pageSubHeaderTextStyle = TextStyle(fontSize:18,fontWeight: FontWeight.w700,color: Colors.black);

  // static final TextStyle normalText = TextStyle(fontWeight: FontWeight.w600, color: Colors.black, letterSpacing: 1, fontSize: 12);
}

/// BorderRadius
class AppBorderStyle {
  static final BorderRadius bigCurve = BorderRadius.circular(20);
  static final BorderRadius midCurve = BorderRadius.circular(15);
  static final BorderRadius smallCurve = BorderRadius.circular(10);
  static final BorderRadius circular = BorderRadius.circular(1000);
}


// class AppDecorations {
//     static final InputDecoration inputDecoration = 
//     InputDecoration(
//       hintText: 'Jane Doe',
//       hintStyle: AppTextStyle.hintTextStyle,
//       contentPadding:EdgeInsets.zero,
//       border: UnderlineInputBorder(
//         borderSide: BorderSide(color: Colors.black,width: 1),
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: Colors.black,width: 1),
//       ),
//     );
// }




/*
#D9E8AB
#AFA79B - text color
#BB9D98
#EDDECC - heading

#C7A38F - icon
#C14040 = highlight 
#E5C9CC - IAP tile
#EB7070 - record button
*/
