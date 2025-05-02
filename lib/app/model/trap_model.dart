enum WindDirection {
  norte,
  sul,
  leste,
  oeste,
}

class TrapModel {
  final String name;
  final DateTime date;
  final int? quantityPests;
  final double? airHumidity;
  final String? windDirection;
  TrapModel(
      {required this.name,
      required this.date,
      this.airHumidity,
      this.quantityPests,
      this.windDirection});

  String selectWindDirection(WindDirection windDirection) {
    if (windDirection == WindDirection.norte) {
      return "Norte";
    } else if (windDirection == WindDirection.sul) {
      return "Sul";
    } else if (windDirection == WindDirection.leste) {
      return "Leste";
    }else if (windDirection == WindDirection.oeste) {
      return "Oeste";
    }
    return "";
  }
}
