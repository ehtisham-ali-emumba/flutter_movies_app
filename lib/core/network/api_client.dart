import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final String? bearerToken;

  ApiClient({required this.baseUrl, this.bearerToken});

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    final response = await http.get(
      uri,
      headers: bearerToken != null
          ? {'Authorization': 'Bearer $bearerToken'}
          : {},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data: \\${response.statusCode}');
    }
  }
}
