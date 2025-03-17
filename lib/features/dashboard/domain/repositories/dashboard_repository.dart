import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/purchase_request_param.dart';

abstract class DashboardRepository {
  // Future<Either<Failure, String>> cartCheckout(List<Map<String, dynamic>> carts);

  Future<Either<Failure, MaterialPurchaseEntity>> getPurchaseData(int page);

  Future<Either<Failure, String>> purchaseRequest(Map<String, dynamic> data);
}
