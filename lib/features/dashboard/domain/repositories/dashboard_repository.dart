import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either<Failure, MaterialPurchaseEntity>> getPurchaseData(int page);

  Future<Either<Failure, String>> purchaseRequest(Map<String, dynamic> data);
}
