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
        backgroundColor: Color.fromARGB(255, 255, 205, 7), 
        textStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
      ),
    ),
    
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 54, 54, 54),
    textTheme: TextTheme(bodySmall: TextStyle(color: Colors.white)),
    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 205, 7), 
        textStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
      )
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color.fromARGB(255, 255, 255, 255),
      disabledBorder: _inputBorder,
      border: _inputBorder,
      enabledBorder: _inputBorder,
      labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
      errorBorder: _inputBorder,
      focusedBorder: _inputBorder,
      focusColor: Colors.grey,
      
    ),
     
    textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.white)
  );
}