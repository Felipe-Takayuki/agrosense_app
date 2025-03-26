
import 'package:agrosense_app/app/ui/screens/home/home.dart';
import 'package:agrosense_app/app/ui/screens/sign_in/sign_in.dart';
import 'package:agrosense_app/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      theme: AgroSenseTheme.theme,
      initialRoute: "/sign_in",
      routes: {
        "/home" : (context) => Home(),
        "/sign_in": (context) => SignIn()
      },
    );
  }
}