import 'package:material_purchase_app/core/error/exception.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/core/extra/network_info.dart';
import 'package:material_purchase_app/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:material_purchase_app/features/dashboard/data/models/material_purchase_model.dart';
import 'package:material_purchase_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final NetworkInfo networkInfo;
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, MaterialPurchaseModel>> getPurchaseData(int page) async {
    try {
      return Right(await remoteDataSource.getPurchaseData(page));
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }
}
