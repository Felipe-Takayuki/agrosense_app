import 'dart:developer';
import 'package:http/http.dart' as http;

class DetectionService {
  testConnection() async {
    final url = "http://[IP]:5000";
    final response = await http.get(Uri.parse(url));
  
    log(response.body);
  }
}
