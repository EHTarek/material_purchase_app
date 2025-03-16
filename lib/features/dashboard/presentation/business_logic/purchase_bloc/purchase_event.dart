part of 'purchase_bloc.dart';

sealed class PurchaseEvent extends Equatable {
  const PurchaseEvent();
}

class GetPurchaseDataEvent extends PurchaseEvent {
  final int page;
  const GetPurchaseDataEvent({required this.page});
  @override
  List<Object?> get props => [page];
}