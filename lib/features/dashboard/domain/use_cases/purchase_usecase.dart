import 'package:material_purchase_app/core/base/empty_param.dart';
import 'package:material_purchase_app/core/base/use_case.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/purchase_request_param.dart';

import '../repositories/dashboard_repository.dart';

final class GetPurchaseData extends UseCase<MaterialPurchaseEntity, int>{
  final DashboardRepository dashboardRepository;
  GetPurchaseData(this.dashboardRepository);

  @override
  Future<Either<Failure, MaterialPurchaseEntity>> call({required int params}) {
    return dashboardRepository.getPurchaseData(params);
  }
}

final class PurchaseRequest extends UseCase<String, PurchaseRequestParam>{
  final DashboardRepository dashboardRepository;
  PurchaseRequest(this.dashboardRepository);

  @override
  Future<Either<Failure, String>> call({required PurchaseRequestParam params}) {
    return dashboardRepository.purchaseRequest(params.toJson());
  }
}