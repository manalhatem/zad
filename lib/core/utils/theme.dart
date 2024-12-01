import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';

///orange and green color not change

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.whiteCol,
      fontFamily: "BEIN",
      dividerColor: AppColors.dividerCol,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primaryColor: AppColors.orangeCol,
      primaryColorLight: AppColors.blackColor,
      cardColor: AppColors.cardColor,
       disabledColor: AppColors.greenWhiteClr,
       textSelectionTheme: const TextSelectionThemeData(
         selectionColor: AppColors.greenColor,
         selectionHandleColor: Colors.transparent,
         cursorColor: AppColors.greenColor
       ),

   unselectedWidgetColor: const Color(0xffFFFDF9),


   textTheme: TextTheme(
        displaySmall: TextStyle(
       color: AppColors.blackColor,
       fontSize: AppFonts.t14,
     ),
        displayMedium: TextStyle(
          color: AppColors.orangeCol,
          fontSize: AppFonts.t16,
        ),
        titleMedium:TextStyle(
         color: AppColors.blackColor,
         fontSize: AppFonts.t16,),
        titleSmall: TextStyle(
        color: AppColors.grayColor2,
         fontSize: AppFonts.t10),
     bodySmall: TextStyle(
       color: AppColors.grayColor2,
       fontSize: AppFonts.t14),
     displayLarge: TextStyle(
         color: AppColors.grayColor3,
         fontSize: AppFonts.t14),
   )

  );
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xff1B1B1B),
      fontFamily: "BEIN",
      dividerColor: AppColors.grayColor,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primaryColor: AppColors.cardDarkColor,
      primaryColorLight: AppColors.whiteCol,
      cardColor: AppColors.cardDarkColor,
      disabledColor: AppColors.blackColor2,

      unselectedWidgetColor: const Color(0xff323232),
      textTheme: TextTheme(
        displaySmall: TextStyle(
          color: AppColors.grayColor2,
          fontSize: AppFonts.t14,
        ),
        displayMedium: TextStyle(
          color: AppColors.orangeCol,
          fontSize: AppFonts.t16,
        ),
        titleMedium:TextStyle(
          color: AppColors.whiteCol,
          fontSize: AppFonts.t16,
        ),
        titleSmall: TextStyle(
            color: AppColors.whiteCol,
            fontSize: AppFonts.t10),
        bodySmall: TextStyle(
            color: AppColors.whiteCol,
            fontSize: AppFonts.t14),
        displayLarge: TextStyle(
            color: AppColors.whiteCol,
            fontSize: AppFonts.t14),

      )
  );
}
