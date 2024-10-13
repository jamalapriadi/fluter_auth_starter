import 'dart:async';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' show Client;

import 'cache_const.dart';
import 'cache_storage.dart';

class Network {
  Client client = Client();

  static const String accept = 'application/json';
  static const String contentType = 'application/x-www-form-urlencoded';

  Future<dynamic> getRequest(String url, {bool withToken = true}) async {
    try {
      final accessToken = await Cache.getCache(key: cacheTokenId);

      final response = await client.get(Uri.parse(dotenv.env['API_URL']!+url), headers: {
        'content-type': contentType,
        'accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      }).timeout(const Duration(seconds: 20));

      return response;
    } on TimeoutException catch (_) {
      throw Exception();
    }
  }

  Future<dynamic> putRequest(String url, dynamic body) async {
    final accessToken = await Cache.getCache(key: cacheTokenId);

    final response = await client.put(Uri.parse(dotenv.env['API_URL']!+url),
        headers: {
          'content-type': contentType,
          'accept': accept,
          HttpHeaders.authorizationHeader: 'Bearer $accessToken'
        },
        body: body);

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  Future<dynamic> postRequestForm(String url, Map<String, dynamic> body) async {
    final accessToken = await Cache.getCache(key: cacheTokenId);
    final response = await client.post(
      Uri.parse(dotenv.env['API_URL']!+url),
      headers: {
        'Accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
      body: body,
    );

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  Future<dynamic> postRequest(String url) async {
    final accessToken = await Cache.getCache(key: cacheTokenId);
    final response = await client.post(
      Uri.parse(dotenv.env['API_URL']!+url),
      headers: {
        'Accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
    );

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  Future<dynamic> postRequestRefreshToken(String url) async {
    final accessToken = await Cache.getCache(key: cacheTokenId);
    final response = await client.post(
      Uri.parse(dotenv.env['API_URL']!+url),
      headers: {
        'Content-Type': contentType,
        'Accept': accept,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
    );

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  Future<dynamic> deleteRequest(String url) async {
    final accessToken = await Cache.getCache(key: cacheTokenId);

    final response = await client.delete(Uri.parse(dotenv.env['API_URL']!+url), headers: {
      'content-type': contentType,
      'accept': accept,
      HttpHeaders.authorizationHeader: 'Bearer $accessToken'
    });

    if (response.statusCode == 401) {
      throw Exception('${response.statusCode}');
    }

    return response;
  }

  Future<dynamic> postRequestWithoutToken(String url, dynamic body) async {
    try {
      final response = await client.post(
        Uri.parse(dotenv.env['API_URL']!+url),
        headers: {
          'Content-Type': contentType,
          'Accept': accept,
        },
        body: body,
      );
      return response;
    } on TimeoutException catch (_) {
      // ignore: no_wildcard_variable_uses
      throw Exception(_);
    }
  }
}
