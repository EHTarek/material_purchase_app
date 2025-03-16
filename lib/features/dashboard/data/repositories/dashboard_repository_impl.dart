import 'package:material_purchase_app/core/error/exception.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/core/extra/network_info.dart';
import 'package:material_purchase_app/features/dashboard/data/data_source/dashboard_local_data_source.dart';
import 'package:material_purchase_app/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:material_purchase_app/features/dashboard/data/models/material_purchase_model.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/cart_products_entity.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/products_entity.dart';
import 'package:material_purchase_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final NetworkInfo networkInfo;
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts() async{
    try {
      return Right(await remoteDataSource.getProducts());
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, List<CartProductsEntity>>> addToCart(Map<String, dynamic> product) async {
    try {
      final cartProducts = await localDataSource.addToCart(product);
      final cartProductsList = cartProducts.map((model) => model.toEntity()).toList();
      return Right(cartProductsList);
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      return Right(await localDataSource.clearCart());
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, List<CartProductsEntity>>> loadCart() async {
    try {
      final cartProducts = await localDataSource.loadCart();
      return Right(cartProducts.map((model) => model.toEntity()).toList());
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, List<CartProductsEntity>>> removeFromCart(int productId) async {
    try {
      final cartProducts = await localDataSource.removeFromCart(productId);
      return Right(cartProducts.map((model) => model.toEntity()).toList());
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, String>> cartCheckout(List<Map<String, dynamic>> carts) async {
    try {
      return Right(await remoteDataSource.cartCheckout(carts));
    } on UnauthorizedException {
      return const Left(TokenInvalid(message: 'Invalid Token'));
    } catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong!'));
    }
  }

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
