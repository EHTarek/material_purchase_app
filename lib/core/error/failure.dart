import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.message});
}

// invalid Token
class TokenInvalid extends Failure {
  const TokenInvalid({required super.message});
}

class TokenExpired extends Failure {
  const TokenExpired({required super.message});
}
