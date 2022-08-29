import 'package:flutter/material.dart';
import 'package:todo_app/src/utils/constants.dart';
import '../../utils/screen_utils/custom_screenutil.dart';

class AppTheme {
  static TextTheme lightTextTheme() {
    return TextTheme(
      subtitle1: TextStyle(
        fontSize: 18.sp,
        color: kPrimaryColor,
      ),
      headline5: TextStyle(
        fontSize: 24.sp,
        color: kPrimaryColor,
      ),
      caption: TextStyle(
        color: kPrimaryColor,
        fontSize: 12.sp,
      ),
    );
  }

  static Theme dialogTheme(Widget child) {
    return Theme(
      child: child,
      data: ThemeData(
        primaryColor: kPrimaryColor,
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      textTheme: lightTextTheme(),
      fontFamily: "Roboto",
      primaryColor: kPrimaryColor,
      splashColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: kPrimaryColor,
        size: 24.sp,
      ),
      dividerColor: kPrimaryLightColor.withOpacity(0.1),
      dividerTheme: DividerThemeData(
        indent: 0,
        thickness: 1.5.h,
        space: 0,
        color: kPrimaryColor.withOpacity(0.1),
      ),
      appBarTheme: AppBarTheme(
          toolbarHeight: 67.h,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            color: kPrimaryColor,
          ),
          shadowColor: Colors.transparent,
          foregroundColor: kPrimaryColor,
          elevation: 0,
          actionsIconTheme: IconThemeData(
            size: 33.w,
          ),
          iconTheme: IconThemeData(size: 33.w)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
          textStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
            vertical: 14.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 18.w,
        ),
        secondaryLabelStyle: TextStyle(
            color: Colors.white, fontFamily: "Roboto", fontSize: 16.sp),
        secondarySelectedColor: kPrimaryColor,
        labelStyle: TextStyle(color: kPrimaryColor, fontSize: 16.sp),
        brightness: Brightness.dark,
        selectedColor: kPrimaryColor,
        disabledColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.zero,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelColor: Colors.white,
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
      ),
    );
  }
}
