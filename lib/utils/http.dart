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

    http.Response res = http.Response('', 500);

    try {
      res = await http.get(
        uri,
        headers: Http.headers,
      );

      if (res.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
        return const JsonDecoder().convert(res.body);
      }
    } on SocketException {
      return {'error': 'NO_INTERNET'};
    } on HttpException {
      return {'error': 'NO_SERVICE'};
    } on FormatException {
      return {'error': 'INVALID_RESPONSE'};
    } catch (e) {
      return {'error': 'UNKNOWN'};
    }

    return {'error': 'UNKNOWN'};
  }

  static Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic>? body}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl$url'),
        body: const JsonEncoder().convert(body),
        headers: Http.headers,
      );

      if (res.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
        return const JsonDecoder().convert(res.body);
      }
    } on SocketException {
      return {'error': 'NO_INTERNET'};
    } on HttpException {
      return {'error': 'NO_SERVICE'};
    } on FormatException {
      return {'error': 'INVALID_RESPONSE'};
    } catch (e) {
      return {'error': 'UNKNOWN'};
    }

    return {'error': 'UNKNOWN'};
  }

  static Future<Map<String, dynamic>> put(String url,
      {Map<String, dynamic>? body, List<http.MultipartFile>? files}) async {
    final uri = Uri.parse('$baseUrl$url');

    if (files != null) {
      final req = http.MultipartRequest('PUT', uri);

      req.files.addAll(files);
      req.headers.addAll(Http.headers);

      body?.forEach((key, value) {
        req.fields[key] = value.toString();
      });

      http.StreamedResponse sres = await req.send();
      http.Response res = await http.Response.fromStream(sres);

      if (res.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
        return const JsonDecoder().convert(res.body);
      }

      return {'error': 'UNKNOWN ${res.statusCode}', 'body': res.body};
    }

    try {
      http.Response res = await http.put(
        uri,
        body: const JsonEncoder().convert(body),
        headers: Http.headers,
      );

      if (res.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
        return const JsonDecoder().convert(res.body);
      }
    } on SocketException {
      return {'error': 'NO_INTERNET'};
    } on HttpException {
      return {'error': 'NO_SERVICE'};
    } on FormatException {
      return {'error': 'INVALID_RESPONSE'};
    } catch (e) {
      return {'error': 'UNKNOWN'};
    }

    return {'error': 'UNKNOWN'};
  }
}
