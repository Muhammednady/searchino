import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const primaryColor = Colors.teal;
const secondaryColor = Color(0xff51eec2);

final appTheme =  ThemeData(
   textTheme:const TextTheme(
      bodyLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.white),
      bodySmall: TextStyle(fontSize: 16, color: Colors.grey),
      displaySmall: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.grey)  
  
    ),
    appBarTheme:const AppBarTheme(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
        //statusBarBrightness: Brightness.light,
      ),
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme:const ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme:const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle:const TextStyle(color: primaryColor),
        floatingLabelStyle:const TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide:const BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide:const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(40),
        )));


// ThemeData lightTheme = ThemeData(
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(
//           fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
//       bodyMedium: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.black),
//       bodySmall: TextStyle(fontSize: 16, color: Colors.grey),
//       displaySmall: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),
//       displayMedium: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.grey)  
  
//     ),
//     fontFamily: 'myfont',
//     primarySwatch: Colors.blue,
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         selectedItemColor: primaryColor,
//         unselectedItemColor: Colors.grey,
//         elevation: 20.0,
//         showUnselectedLabels: true),
//     scaffoldBackgroundColor: Colors.white,
//     appBarTheme: AppBarTheme(
//       systemOverlayStyle:  SystemUiOverlayStyle(
//         statusBarColor: Colors.white,
//         statusBarIconBrightness: Brightness.dark,
//         //statusBarBrightness: Brightness.light,
//       ),
//       iconTheme: IconThemeData(color: Colors.black),
//       titleSpacing: 10.0,
//       titleTextStyle: TextStyle(
//           color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w900),
//       color: Colors.white,
//       elevation: 0.0,
//     ));

// ThemeData darkTheme = ThemeData(
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(
//           fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
//       bodyMedium: TextStyle(fontSize: 18, color: Colors.grey),
//       bodySmall: TextStyle(fontSize: 16.0, color: Colors.grey),
//     ),
//     fontFamily: 'myfont',
//     primarySwatch: Colors.amber,
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: HexColor('333734'),
//         selectedItemColor: defaultColor,
//         unselectedItemColor: Colors.grey,
//         elevation: 20.0,
//         showUnselectedLabels: true),
//     scaffoldBackgroundColor: HexColor('333734'),
//     appBarTheme: AppBarTheme(
//       systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: HexColor('333734'),
//         statusBarIconBrightness: Brightness.light,
//         //statusBarBrightness: Brightness.light,
//       ),
//       iconTheme: IconThemeData(color: Colors.white),
//       titleSpacing: 10.0,
//       titleTextStyle: TextStyle(
//           color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w900),
//       color: HexColor('333734'),
//       elevation: 0.0,
//     ));

