import 'package:flutter/material.dart';

class AgroSenseTheme{
  static const _inputBorder =  UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(width: 0, style: BorderStyle.solid, )
  );

  static const _floatActionButtonStyle = FloatingActionButtonThemeData(backgroundColor: Color.fromARGB(255, 255, 205, 7));
  static const _textStyle = TextTheme(
    bodySmall: TextStyle(fontSize: 15), // para os botões 
    bodyMedium: TextStyle(fontSize: 20), 
  );
    
  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: _textStyle.apply(bodyColor: Colors.black),
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

    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 205, 7), 
        textStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
      ),
    ),
    
  );

  static final darkTheme = ThemeData(
    textTheme: _textStyle.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white
    ),
    floatingActionButtonTheme: _floatActionButtonStyle,
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
     
  );
}