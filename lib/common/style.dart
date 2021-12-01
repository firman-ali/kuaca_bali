import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    onPrimary: onSecondary,
    primary: secondary300,
    textStyle: textTheme.button,
  ),
);

TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    primary: onPrimaryBlack,
  ),
);

TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.firaSansCondensed(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    color: onPrimaryBlack,
  ),
  headline2: GoogleFonts.firaSansCondensed(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: onPrimaryBlack,
  ),
  headline3: GoogleFonts.firaSansCondensed(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: onPrimaryBlack,
  ),
  headline4: GoogleFonts.firaSansCondensed(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: onPrimaryBlack,
  ),
  headline5: GoogleFonts.firaSansCondensed(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: onPrimaryBlack,
  ),
  headline6: GoogleFonts.firaSansCondensed(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: onPrimaryBlack,
  ),
  subtitle1: GoogleFonts.firaSansCondensed(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: onPrimaryBlack,
  ),
  subtitle2: GoogleFonts.firaSansCondensed(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  bodyText1: GoogleFonts.publicSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
  bodyText2: GoogleFonts.publicSans(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  ),
  button: GoogleFonts.publicSans(
    color: onSecondary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  caption: GoogleFonts.publicSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: onSurface,
  ),
);

InputDecorationTheme inputTheme = InputDecorationTheme(
  filled: true,
  fillColor: surface,
  contentPadding: const EdgeInsets.all(0),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.0),
  ),
  labelStyle: textTheme.caption,
  focusColor: primary300,
  errorStyle: textTheme.bodyText1,
);
