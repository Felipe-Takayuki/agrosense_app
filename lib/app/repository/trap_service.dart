import 'dart:convert';
import 'dart:developer';
import 'package:agrosense_app/app/model/trap_model.dart';
import 'package:agrosense_app/app/model/weather_model.dart';
import 'package:agrosense_app/app/service/open_meteo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrapRepository {
  Future<SharedPreferences> _instance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  Future<void> addTrap(String trapName, String imagePath) async {
    final instance = await _instance();
    List<String> listaAtual = instance.getStringList('traps') ?? [];
    final meteoService = OpenMeteoService();
    final weatherInfos = await meteoService.getOpenMeteoInfo();
    listaAtual.add(jsonEncode(TrapModel(
      imagePath: imagePath,
      name: trapName,
      date: DateTime.now(),
      weatherModel: WeatherModel(
        airHumidity: weatherInfos.airHumidity,
        temperature: weatherInfos.temperature,
        windDirection: weatherInfos.windDirection,
      ),
    ).toJson()));

    await instance.setStringList('traps', listaAtual);
  }

  Future<List<TrapModel>> getTraps() async {
    final instance = await _instance();
    List<String> rawList = instance.getStringList('traps') ?? [];
    log("traps do repo: ${rawList.length}");
    return rawList.map((item) {
      final decoded = jsonDecode(item);
      return TrapModel.fromJson(decoded);
    }).toList();
  }

Future<void> saveTrap(String trapName, String imagePath) async {
  final instance = await _instance();
  final meteoService = OpenMeteoService();
  final weatherInfos = await meteoService.getOpenMeteoInfo();

  final trap = TrapModel(
    imagePath: imagePath,
    name: trapName,
    date: DateTime.now(),
    weatherModel: WeatherModel(
      airHumidity: weatherInfos.airHumidity,
      temperature: weatherInfos.temperature,
      windDirection: weatherInfos.windDirection,
    ),
  );
  final trapJson = jsonEncode(trap.toJson());

  List<String> listaAtual = instance.getStringList('traps') ?? [];

  listaAtual.add(trapJson);
  await instance.setStringList('traps', listaAtual);
}

}
