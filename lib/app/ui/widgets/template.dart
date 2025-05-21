import 'package:flutter/material.dart';

class TemplateWidget extends StatefulWidget {
  const TemplateWidget({super.key, required this.child,  this.height});
  final Widget child;
  final double? height;

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/background_light.png"), fit: BoxFit.cover)
          ),
          child: widget.child,
    );
  }
}