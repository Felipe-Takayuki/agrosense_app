import 'package:flutter/material.dart';

class AgroSenseTheme {
  static const _inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
    width: 2,
    style: BorderStyle.solid,
    color: Color(0xff9A7D08),
  ));

  static const _floatActionButtonStyle = FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 255, 205, 7));
  static const _textStyle = TextTheme(
      labelMedium: TextStyle(fontSize: 18), // para os botões
      labelSmall: TextStyle(fontSize: 14),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  static final theme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 239, 239, 239)),
      scaffoldBackgroundColor: Colors.white,
      textTheme:
          _textStyle.apply(bodyColor: const Color.fromARGB(255, 22, 22, 22)),
      inputDecorationTheme: InputDecorationTheme(
        disabledBorder: _inputBorder,
        border: _inputBorder,
        enabledBorder: _inputBorder,
        labelStyle: TextStyle(color: Colors.black),
        errorBorder: _inputBorder,
        focusedBorder: _inputBorder,
        focusColor: Colors.grey,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 255, 205, 7),
            textStyle: TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
      floatingActionButtonTheme: _floatActionButtonStyle);

  // static final darkTheme = ThemeData(
  //   appBarTheme:
  //       AppBarTheme(backgroundColor: const Color.fromARGB(255, 7, 39, 65)),
  //   textTheme:
  //       _textStyle.apply(bodyColor: Colors.white, displayColor: Colors.white),
  //   floatingActionButtonTheme: _floatActionButtonStyle,
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //           backgroundColor: Color.fromARGB(255, 255, 205, 7),
  //           textStyle: TextStyle(color: Colors.white),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(10))))),
  //   inputDecorationTheme: InputDecorationTheme(
  //     filled: true,
  //     fillColor: Color.fromARGB(255, 255, 255, 255),
  //     disabledBorder: _inputBorder,
  //     border: _inputBorder,
  //     enabledBorder: _inputBorder,
  //     labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
  //     errorBorder: _inputBorder,
  //     focusedBorder: _inputBorder,
  //     focusColor: Colors.grey,
  //   ),
  // );
}
