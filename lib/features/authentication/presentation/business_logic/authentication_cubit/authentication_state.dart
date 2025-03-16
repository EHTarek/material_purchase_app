part of 'authentication_cubit.dart';

sealed class AuthenticationCubitState extends Equatable {
  const AuthenticationCubitState();
}

final class AuthenticationCubitInitial extends AuthenticationCubitState {
  @override
  List<Object> get props => [];
}

final class AuthenticationCheckboxToggled extends AuthenticationCubitState {
  final bool isChecked;
  const AuthenticationCheckboxToggled(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}
