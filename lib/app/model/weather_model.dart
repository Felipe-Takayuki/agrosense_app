class WeatherModel {
  final double airHumidity;
  final double temperature;
  final double windDirection;

  WeatherModel({required this.airHumidity, required this.temperature, required this.windDirection});

    factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['temperature'],
      airHumidity: json['airHumidity'] ,
      windDirection: json['windDirection'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'airHumidity': airHumidity,
      'windDirection': windDirection,
    };
  }
   String toWindDirectionString() {
    switch (windDirection) {
      case >= 0 && < 45:
        return "Norte";
      case >= 45 && < 90:
        return "Nordeste";
      case >= 90 && < 135:
        return "Leste";
      case >= 135 && < 180:
        return "Sudeste";
      case >= 180 && < 225:
        return "Sul";
      case >= 225 && < 270:
        return "Sudoeste";
      case >= 270 && < 315:
        return "Oeste";
      case >= 315 && <= 360:
        return "Noroeste";
      default:
        return "";
    }
  }
}

