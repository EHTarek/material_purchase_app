part of 'purchase_bloc.dart';

sealed class PurchaseState extends Equatable {
  const PurchaseState();
}

final class PurchaseInitial extends PurchaseState {
  @override
  List<Object> get props => [];
}

final class PurchaseLoading extends PurchaseState {
  @override
  List<Object> get props => [];
}

final class PurchaseLoaded extends PurchaseState {
  final MaterialPurchaseEntity materialPurchaseEntity;
  final List<DataEntity> purchaseResult;

  const PurchaseLoaded({
    required this.materialPurchaseEntity,
    required this.purchaseResult,
  });

  @override
  List<Object> get props => [materialPurchaseEntity, purchaseResult];
}

final class PurchaseSearchLoaded extends PurchaseState {
  final MaterialPurchaseEntity materialPurchaseEntity;
  final List<DataEntity> searchResult;

  const PurchaseSearchLoaded({
    required this.materialPurchaseEntity,
    required this.searchResult,
  });

  @override
  List<Object> get props => [materialPurchaseEntity, searchResult];
}

final class PurchaseRequestSuccess extends PurchaseState {
  final String message;

  const PurchaseRequestSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class PurchaseError extends PurchaseState {
  final String message;

  const PurchaseError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class PurchaseNoInternet extends PurchaseState {
  @override
  List<Object> get props => [];
}

final class PurchaseSessionOut extends PurchaseState {
  @override
  List<Object> get props => [];
}