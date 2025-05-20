import 'package:agrosense_app/app/model/weather_model.dart';

class TrapModel {
  final String imagePath;
  final String name;
  final DateTime date;
  WeatherModel weatherModel;

  TrapModel(
      {required this.imagePath,
      required this.name,
      required this.date,
      required this.weatherModel});

  // Serialização para JSON
  Map<String, dynamic> toJson() {
    return {
      'image_path': imagePath,
      'name': name,
      'date': date.toIso8601String(),
      'weatherInfo': weatherModel.toJson()
    };
  }

  factory TrapModel.fromJson(Map<String, dynamic> json) {
    return TrapModel(
      imagePath: json['image_path'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      weatherModel: WeatherModel.fromJson(json['weatherInfo']),
    );
  }
  
}
