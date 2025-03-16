import 'package:material_purchase_app/core/base/empty_param.dart';
import 'package:material_purchase_app/core/base/use_case.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/authentication/domain/entity/login_entity.dart';
import 'package:material_purchase_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

final class GetUserData extends UseCase<LoginResponseEntity, EmptyParam> {
  final AuthenticationRepository repository;

  GetUserData(this.repository);

  @override
  Future<Either<Failure, LoginResponseEntity>> call({required EmptyParam params}) async {
    return repository.getUserData();
  }
}
