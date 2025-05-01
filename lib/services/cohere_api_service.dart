// lib/services/cohere_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class CohereApiService {
  final String _apiKey =
      'nusYxHqYR57RUnPMqY5NvjN71NZJ6hSdUhgiPyAk'; // Replace this
  final String _url = 'https://api.cohere.ai/v1/chat';

  Future<String> getChatResponse(String message) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': message,
        'model': 'command-r-plus',
        'stream': false,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['text'] != null) {
      return data['text'];
    } else {
      throw Exception(
          'Failed to get response: ${data['message'] ?? response.body}');
    }
  }
}
