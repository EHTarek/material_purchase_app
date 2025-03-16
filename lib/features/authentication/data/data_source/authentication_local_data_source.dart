import 'dart:convert';
import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/cached/preferences_key.dart';
import 'package:material_purchase_app/core/error/exception.dart';
import 'package:material_purchase_app/features/authentication/data/model/login_model.dart';

abstract interface class AuthenticationLocalDataSource {
  Future<LoginResponseModel> getUserData();
}

class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  AuthenticationLocalDataSourceImpl({required this.prefs});
  final Preferences prefs;

  @override
  Future<LoginResponseModel> getUserData() async {
    final userData = await prefs.getSecureStringValue(keyName: PreferencesKey.kUserAuthData);
    if(userData.isNotEmpty){
      return LoginResponseModel.fromJson(jsonDecode(userData));
    } else {
      throw UnauthorizedException();
    }
  }
}
