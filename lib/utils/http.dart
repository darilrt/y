import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Http {
  static const String baseUrl = 'http://192.168.1.6:8000';
  static String bearerToken = '';

  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  static void setBearerToken(String token) {
    bearerToken = token;
    headers[HttpHeaders.authorizationHeader] = 'Bearer $bearerToken';
  }

  static Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic>? params}) async {
    Uri uri = Uri.parse('$baseUrl$url');

    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }

    http.Response res = await http.get(
      uri,
      headers: Http.headers,
    );

    if (res.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
      return const JsonDecoder().convert(res.body);
    }

    return {};
  }

  static Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic>? body}) async {
    http.Response res = await http.post(
      Uri.parse('$baseUrl$url'),
      body: const JsonEncoder().convert(body),
      headers: Http.headers,
    );

    if (res.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
      return const JsonDecoder().convert(res.body);
    }

    return {};
  }
}
