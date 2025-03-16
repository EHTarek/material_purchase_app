import 'package:material_purchase_app/core/base/empty_param.dart';
import 'package:material_purchase_app/core/base/use_case.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/products_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/dashboard_repository.dart';

final class GetProducts extends UseCase<List<ProductsEntity>, EmptyParam>{
  final DashboardRepository dashboardRepository;
  GetProducts(this.dashboardRepository);

  @override
  Future<Either<Failure, List<ProductsEntity>>> call({required EmptyParam params}) {
    return dashboardRepository.getProducts();
  }
}