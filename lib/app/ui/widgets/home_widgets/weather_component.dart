import 'package:agrosense_app/app/ui/screens/home/home_controller.dart';
import 'package:agrosense_app/app/ui/widgets/home_widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class WeatherComponent extends StatefulWidget {
  final HomeController controller;
  final Size size;
  const WeatherComponent(
      {super.key, required this.controller, required this.size});

  @override
  State<WeatherComponent> createState() => _WeatherComponentState();
}

// WeatherComponent.dart
class _WeatherComponentState extends State<WeatherComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.88,
      // height removido para ajustar automaticamente
      padding: const EdgeInsets.all(20), 
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 205, 7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.controller.selectedTrap!.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(DateFormat("dd/MM/yyyy").format(widget.controller.selectedTrap!.date)),
          const SizedBox(height: 8),
          WeatherInfo(
            label: "Umidade Relativa",
            info: "${widget.controller.selectedTrap?.weatherModel.airHumidity}",
            icon: Icons.water_drop,
            color: Colors.blue,
          ),
          const Divider(color: Colors.blue),
          WeatherInfo(
            label: "Temperatura",
            info: "${widget.controller.selectedTrap!.weatherModel.temperature} ºC",
            icon: Icons.thermostat,
            color: Colors.red,
          ),
          const Divider(color: Colors.red),
          WeatherInfo(
            label: "Direção do Vento",
            info: widget.controller.selectedTrap!.weatherModel.toWindDirectionString(),
            icon: Icons.wind_power_outlined, 
            color: Colors.green,
          ),
          const Divider(color: Colors.green),
        ],
      ),
    );
  }
}
