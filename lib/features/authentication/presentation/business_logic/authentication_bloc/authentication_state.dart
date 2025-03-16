part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}
final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationLoginSuccess extends AuthenticationState {
  final LoginResponseEntity loginResponse;
  const AuthenticationLoginSuccess(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

final class AuthenticationLogoutInitial extends AuthenticationState {}
final class AuthenticationLogoutSuccess extends AuthenticationState {}

final class AuthenticationFailure extends AuthenticationState {
  final String message;
  const AuthenticationFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthenticationNoInternet extends AuthenticationState {}

final class AuthenticationSessionOut extends AuthenticationState {}

final class AuthenticationUserDataLoaded extends AuthenticationState {
  final LoginResponseEntity loginResponse;
  const AuthenticationUserDataLoaded(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}