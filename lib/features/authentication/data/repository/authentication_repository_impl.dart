import 'package:material_purchase_app/core/base/empty_param.dart';
import 'package:material_purchase_app/core/error/exception.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/core/extra/network_info.dart';
import 'package:material_purchase_app/features/authentication/data/data_source/authentication_local_data_source.dart';
import 'package:material_purchase_app/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:material_purchase_app/features/authentication/data/model/login_model.dart';
import 'package:material_purchase_app/features/authentication/domain/entity/login_entity.dart';
import 'package:material_purchase_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';


final class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource remote;
  final AuthenticationLocalDataSource local;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remote, required this.networkInfo, required this.local
  });

  @override
  Future<Either<Failure, LoginResponseEntity>> login(LoginRequestEntity data) async {
    try {
      return Right(await remote.login(data.toJson()));
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Email or Password is incorrect!'));
    } catch (_) {
      return const Left(ServerFailure(message: 'No Internet Connection!'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout(EmptyParam data) async {
    try {
      return Right(await remote.logout());
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> getUserData() async {
    try {
      return Right(await local.getUserData());
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }
}