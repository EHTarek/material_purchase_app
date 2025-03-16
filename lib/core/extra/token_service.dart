import 'dart:convert';
import 'package:material_purchase_app/core/api/api_client.dart';
import 'package:material_purchase_app/core/api/api_endpoints.dart';
import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/cached/preferences_key.dart';
import 'package:material_purchase_app/core/di/dependency_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class TokenService {
  Future<String> getToken();
  Future<bool> saveToken(String accessToken);
  void clearToken();
}

class TokenServiceImpl extends TokenService {
  TokenServiceImpl({required this.preferences, required this.client});

  final Preferences preferences;
  final Client client;

  @override
  Future<String> getToken() async {
    String accessToken = await preferences.getSecureStringValue(keyName: PreferencesKey.kAccessToken);

    try {
      if (accessToken.isNotEmpty) {
        return accessToken;

        /*if (!JwtDecoder.isExpired(accessToken)) {
          return accessToken;
        } else if (!JwtDecoder.isExpired(refreshToken)) {
          return await _refresh(refreshToken);
        }*/
      }
    } catch (e) {
      debugPrint('Token Error: $e');
    }
    return '';
  }

  @override
  Future<bool> saveToken(String accessToken) async {
    await preferences.setSecureStringValue(keyName: PreferencesKey.kAccessToken, value: accessToken);

    final apiClient = sl.get<ApiClient>();
    await apiClient.initialize();
    return true;
  }

  @override
  void clearToken() {
    preferences.clearOne(keyName: PreferencesKey.kAccessToken);
  }
}
