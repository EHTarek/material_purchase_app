import 'package:material_purchase_app/core/base/empty_param.dart';
import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/cached/preferences_key.dart';
import 'package:material_purchase_app/core/di/dependency_injection.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/authentication/domain/entity/login_entity.dart';
import 'package:material_purchase_app/features/authentication/domain/use_case/authentication_use_case.dart';
import 'package:material_purchase_app/features/authentication/domain/use_case/user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetUserData getUserData;

  final prefs = sl<Preferences>();

  AuthenticationBloc({
    required this.loginUseCase, required this.logoutUseCase, required this.getUserData,
  }) : super(AuthenticationInitial()) {
    on<LoginRequested>(_onLoginRequestedEvent);
    on<LogoutRequested>(_onLogoutRequestedEvent);
    on<GetLoggedInUserData>(_onGetLoggedInUserData);
  }

  Future<void> _onLoginRequestedEvent(LoginRequested event, Emitter<AuthenticationState> emit) async {
    print('LoginRequested');
    emit(AuthenticationLoading());
    final result = await loginUseCase(params: LoginRequestEntity(
      email: event.email, password: event.password,
    ));

    if(event.isRememberMeChecked){
      await prefs.setStringValue(keyName: PreferencesKey.kUserEmail, value: event.email);
      await prefs.setStringValue(keyName: PreferencesKey.kUserPass, value: event.password);
    }

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(AuthenticationNoInternet());
          default:
            return emit(AuthenticationFailure(failure.message));
        }
      },
      (loginResponse) {
        return emit(AuthenticationLoginSuccess(loginResponse));
      },
    );
  }

  Future<void> _onLogoutRequestedEvent(LogoutRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLogoutInitial());
    final result = await logoutUseCase(params: EmptyParam());

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(AuthenticationNoInternet());
          case const (TokenInvalid):
            return emit(AuthenticationSessionOut());
          default:
            return emit(AuthenticationFailure(failure.message));
        }
      },
      (success) {
        return emit(AuthenticationLogoutSuccess());
      },
    );
  }

   _onGetLoggedInUserData(GetLoggedInUserData event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final result = await getUserData(params: EmptyParam());

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(AuthenticationNoInternet());
          default:
            return emit(AuthenticationFailure(failure.message));
        }
      },
      (loginResponse) => emit(AuthenticationUserDataLoaded(loginResponse)),
    );
  }
}
