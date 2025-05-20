import 'package:flutter/material.dart';

class WeatherInfo extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final String info;
  const WeatherInfo(
      {super.key,
      required this.label,
      required this.info,
      required this.icon,
      required this.color});

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.icon,
          color: widget.color,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.label}:",
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: widget.color),
            ),
            Text(
              widget.info,
              style:
                  TextStyle(color: widget.color, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
