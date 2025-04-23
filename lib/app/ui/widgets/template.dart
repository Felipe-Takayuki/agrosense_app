import 'package:flutter/material.dart';

class TemplateWidget extends StatefulWidget {
  const TemplateWidget({super.key, required this.child, required this.height});
  final Widget child;
  final double height;

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  
  @override
  Widget build(BuildContext context) {
    Brightness bright = MediaQuery.of(context).platformBrightness;

    return Container(
          height: widget.height,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(bright == Brightness.light ? "assets/images/background_light.png" : "assets/images/background.png" ), fit: BoxFit.cover)
          ),
          child: widget.child,
    );
  }
}