import 'dart:convert';
import 'dart:developer';
import 'package:agrosense_app/app/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class OpenMeteoService {
  double lat = 0;
  double long = 0;
  WeatherModel weatherModel =
      WeatherModel(airHumidity: 0, temperature: 0, windDirection: 0);

  _getPosition() async {
    LocationPermission permission;

    bool isActive = await Geolocator.isLocationServiceEnabled();
    if (!isActive) {
      log("Ative a localização");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Permissão negada");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      log("Permissão negada");
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<WeatherModel> getOpenMeteoInfo() async {
    try {
      Position position = await _getPosition();
      lat = position.latitude;
      long = position.longitude;
      final url =
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current=temperature_2m,relative_humidity_2m,wind_direction_10m';
      final response = await http.get(Uri.parse(url));

      final current = jsonDecode(response.body)['current'];
      weatherModel = WeatherModel(
        airHumidity: (current['relative_humidity_2m'] as num).toDouble(),
        temperature: (current['temperature_2m'] as num).toDouble(),
        windDirection: (current['wind_direction_10m'] as num).toDouble(),
      );
      return weatherModel;
    } catch (e) {
      log(e.toString());
      return WeatherModel(airHumidity: 0, temperature: 0, windDirection: 0);
    }
  }
}
