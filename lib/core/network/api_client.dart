import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/main.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiClient {
  final String baseUrl;
  final String apiKey;

  ApiClient({required this.baseUrl, required this.apiKey});

  Future<http.Response> get(String endpoint, Map<String, String> params) async {
    Uri uri = Uri.parse(baseUrl);
    final url = Uri(
      scheme: uri.scheme,
      host: uri.host,
      path: endpoint,
      queryParameters: params,
    );
    logger.d("parameters: $params");
    logger.i("url: $url");
    try {
      final headers = {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
        // Agrega más encabezados si es necesario
      };

      final response = await http.get(url, headers: headers);

      // Manejo de errores comunes
      switch (response.statusCode) {
        case 200:
        case 201:
          return response;
        case 401:
          throw const AuthenticationFailure();
        case 403:
          throw const SuspendedApiKeyFailure();
        case 404:
          throw const ResourceNotFoundFailure();
        case 500:
          throw const InternalServerErrorFailure();
        case 503:
          throw const ServiceOfflineFailure();
        default:
          throw const UnknownErrorFailure(message: "An unknown error occurred");
      }
    } on SocketException {
      throw const ConnectionFailure();
    } catch (e) {
      throw UnknownErrorFailure(message: e.toString());
    }
  }
}
