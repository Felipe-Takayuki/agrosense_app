import 'package:flutter/material.dart';

class AgroSenseTheme{
 static const _inputBorder =  UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(width: 0, style: BorderStyle.solid, )
    );

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xffC9C9C9),
      disabledBorder: _inputBorder,
      border: _inputBorder,
      enabledBorder: _inputBorder,
      labelStyle: TextStyle(color: Colors.black),
      errorBorder: _inputBorder,
      focusedBorder: _inputBorder,
      focusColor: Colors.grey,
      
    ), 
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black, 
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffB79408), 
        textStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
      )
      
    )
  );
}