import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/cached/preferences_key.dart';
import 'package:material_purchase_app/core/di/dependency_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationCubitState> {
  AuthenticationCubit() : super(AuthenticationCubitInitial());

  final prefs = sl<Preferences>();

  bool isRememberMeChecked = false;
  void toggleRememberMe(bool value) {
    isRememberMeChecked = value;
    emit(AuthenticationCheckboxToggled(value));
  }

  Future<bool> isUserLoggedIn() async {
    String token = await prefs.getSecureStringValue(keyName: PreferencesKey.kAccessToken);
    return token.isNotEmpty;
  }

}
