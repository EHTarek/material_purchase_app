import 'package:material_purchase_app/core/base/empty_param.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/base/use_case.dart';
import '../entity/login_entity.dart';
import '../repository/authentication_repository.dart';

final class LoginUseCase extends UseCase<LoginResponseEntity, LoginRequestEntity> {
  final AuthenticationRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginResponseEntity>> call({required LoginRequestEntity params}) async {
    return repository.login(params);
  }
}

final class LogoutUseCase extends UseCase<bool, EmptyParam> {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call({required EmptyParam params}) async {
    return repository.logout(params);
  }
}