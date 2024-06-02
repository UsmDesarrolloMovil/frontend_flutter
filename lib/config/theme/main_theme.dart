import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorSeed = Colors.red[700];

class MainTheme {
  ThemeData getTheme() => ThemeData(
        ///* General
        useMaterial3: true,
        colorSchemeSeed: colorSeed,
        brightness: Brightness.dark,

        ///* Texts
        textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          titleSmall: GoogleFonts.montserratAlternates().copyWith(fontSize: 20),
        ),

        ///* Buttons
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.montserratAlternates().copyWith(
                  fontWeight: FontWeight.w700, fontSize: 20, letterSpacing: 1),
            ),
          ),
        ),

        ///* AppBar
        appBarTheme: AppBarTheme(
          toolbarHeight: 90,
          titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
