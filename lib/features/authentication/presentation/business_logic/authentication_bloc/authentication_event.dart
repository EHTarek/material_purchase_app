part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final bool isRememberMeChecked;
  const LoginRequested({required this.email, required this.password, required this.isRememberMeChecked});

  @override
  List<Object> get props => [email, password, isRememberMeChecked];
}

class LogoutRequested extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class GetLoggedInUserData extends AuthenticationEvent {
  const GetLoggedInUserData();
  @override
  List<Object> get props => [];
}