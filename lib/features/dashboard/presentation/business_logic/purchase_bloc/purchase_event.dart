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

class SearchPurchaseEvent extends PurchaseEvent {
  final String query;
  const SearchPurchaseEvent({required this.query});
  @override
  List<Object?> get props => [query];
}

class PurchaseRequestEvent extends PurchaseEvent {
  final PurchaseRequestParam param;
  const PurchaseRequestEvent({required this.param});
  @override
  List<Object?> get props => [param];
}