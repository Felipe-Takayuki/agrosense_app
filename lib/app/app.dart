
import 'package:agrosense_app/app/router/router.dart';
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AgroSenseTheme.theme,
      routerConfig: ConfigRouter().router,
    );
  }
}
