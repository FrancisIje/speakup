import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData appThemeData = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color(0xFFE7E3FF),
  ),
  useMaterial3: true,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0x52808080),
  ),
  dividerTheme: const DividerThemeData(thickness: 0.4),
  dividerColor: Colors.white,
  bottomSheetTheme: BottomSheetThemeData(
      // constraints: BoxConstraints(maxHeight: 330.h),
      backgroundColor: const Color(0xFF222222),
      modalBackgroundColor: const Color(0xFF222222),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13.r), topRight: Radius.circular(13.r)),
      )),
  scaffoldBackgroundColor: const Color(0xFFE7E3FF),
  listTileTheme: ListTileThemeData(
    shape: null,
    selectedColor: Colors.white,
    textColor: Colors.black,
    selectedTileColor: const Color(0xFF222222),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
  ),
  checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      checkColor: const MaterialStatePropertyAll(Colors.transparent),
      fillColor: const MaterialStatePropertyAll(Colors.transparent)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(const Color(0xFFFF8F3E)),
      elevation: const MaterialStatePropertyAll(2),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(32.r), right: Radius.circular(32.r)))),
      textStyle: MaterialStateProperty.all(TextStyle(
          color: const Color(0xFFFF8F3E),
          decorationColor: const Color(0xFFFF8F3E),
          fontSize: 15.sp,
          fontWeight: FontWeight.w600)),
      backgroundColor:
          MaterialStateProperty.all(const Color.fromARGB(32, 255, 139, 87)),
    ),
  ),
);
