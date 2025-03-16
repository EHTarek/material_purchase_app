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

  const PurchaseLoaded({
    required this.materialPurchaseEntity,
  });

  @override
  List<Object> get props => [materialPurchaseEntity];
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