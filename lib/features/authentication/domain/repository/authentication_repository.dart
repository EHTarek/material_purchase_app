
import 'package:material_purchase_app/core/base/repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/base/empty_param.dart';
import '../../../../core/error/failure.dart';
import '../entity/login_entity.dart';

abstract base class AuthenticationRepository extends Repository {
  Future<Either<Failure, LoginResponseEntity>> login(LoginRequestEntity data);

  Future<Either<Failure, LoginResponseEntity>> getUserData();

  Future<Either<Failure, bool>> logout(EmptyParam data);
}
