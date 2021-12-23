import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    onPrimary: onSecondary,
    primary: secondary,
    textStyle: textTheme.button,
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

TextButtonThemeData textButtonLightTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    primary: onPrimaryBlack,
  ),
);

TextButtonThemeData textButtonDarkTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    primary: onPrimaryWhite,
  ),
);

TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.firaSansCondensed(
    fontSize: 82.5,
    fontWeight: FontWeight.w500,
  ),
  headline2: GoogleFonts.firaSansCondensed(
    fontSize: 66,
    fontWeight: FontWeight.w500,
  ),
  headline3: GoogleFonts.firaSansCondensed(
    fontSize: 52.8,
    fontWeight: FontWeight.w500,
  ),
  headline4: GoogleFonts.firaSansCondensed(
    fontSize: 42.2,
    fontWeight: FontWeight.w500,
  ),
  headline5: GoogleFonts.firaSansCondensed(
    fontSize: 33.75,
    fontWeight: FontWeight.w500,
  ),
  headline6: GoogleFonts.firaSansCondensed(
    fontSize: 27,
    fontWeight: FontWeight.w500,
  ),
  subtitle1: GoogleFonts.firaSansCondensed(
    fontSize: 21.9,
    fontWeight: FontWeight.w400,
  ),
  subtitle2: GoogleFonts.firaSansCondensed(
    fontSize: 17.5,
    fontWeight: FontWeight.w400,
  ),
  bodyText1: GoogleFonts.publicSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  bodyText2: GoogleFonts.publicSans(
    fontSize: 11.2,
    fontWeight: FontWeight.w500,
  ),
  button: GoogleFonts.publicSans(
    color: onSecondary,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  caption: GoogleFonts.publicSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
);

InputDecorationTheme inputLightTheme = InputDecorationTheme(
  filled: true,
  fillColor: surface,
  contentPadding: const EdgeInsets.all(0),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.0),
  ),
  labelStyle: textTheme.caption?.copyWith(color: onSurface),
  focusColor: primary300,
  errorStyle: textTheme.bodyText1,
);

InputDecorationTheme inputDarkTheme = InputDecorationTheme(
  filled: true,
  fillColor: surface.withOpacity(0.2),
  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.0),
  ),
  labelStyle: textTheme.caption,
  focusColor: primary300,
  errorStyle: textTheme.bodyText1,
);

IconThemeData iconThemeLightData = const IconThemeData(color: primary600);

IconThemeData iconThemeDarkData = const IconThemeData(color: primary100);

ThemeData lightTheme = ThemeData(
  textTheme: textTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  textButtonTheme: textButtonLightTheme,
  inputDecorationTheme: inputLightTheme,
  backgroundColor: background,
  iconTheme: iconThemeLightData,
  buttonColor: onBackground,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  textTheme: textTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  textButtonTheme: textButtonDarkTheme,
  inputDecorationTheme: inputDarkTheme,
  backgroundColor: background,
  iconTheme: iconThemeDarkData,
  buttonColor: onPrimaryWhite,
);
