import 'dart:convert';

import 'package:material_purchase_app/core/api/api_client.dart';
import 'package:material_purchase_app/core/api/api_endpoints.dart';
import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/cached/preferences_key.dart';
import 'package:material_purchase_app/core/error/exception.dart';
import 'package:material_purchase_app/core/extra/token_service.dart';
import 'package:material_purchase_app/features/authentication/data/model/login_model.dart';

abstract interface class AuthenticationRemoteDataSource {
  Future<LoginResponseModel> login(Map<String, dynamic> data);

  Future<bool> logout();
}

class AuthenticationDataRemoteSourceImpl implements AuthenticationRemoteDataSource {
  AuthenticationDataRemoteSourceImpl({
    required this.client, required this.prefs, required this.tokenService,
  });
  final Preferences prefs;
  final ApiClient client;
  final TokenService tokenService;

  @override
  Future<LoginResponseModel> login(Map<String, dynamic> data) async {

    print('login data: $data');

    final response =  await client.postData(ApiEndpoints.userLogin(), data);
    if(response.statusCode == 200){
      final loginResponse = LoginResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      await prefs.setSecureStringValue(
        keyName: PreferencesKey.kUserAuthData,
        value: jsonEncode(loginResponse.toJson()),
      );
      await tokenService.saveToken(loginResponse.accessToken ?? '');

      return loginResponse;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> logout() async {
    tokenService.clearToken();
    return true;
  }
}
