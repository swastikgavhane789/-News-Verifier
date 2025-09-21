import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000"; 
  // Replace with your backend IP when testing on a real device

  static Future<Map<String, dynamic>> verifyText(String text) async {
    final url = Uri.parse('$baseUrl/verify-text');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"text": text}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify text: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> verifyImage(File imageFile) async {
    final url = Uri.parse('$baseUrl/verify-image');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify image: ${response.body}');
    }
  }
}
