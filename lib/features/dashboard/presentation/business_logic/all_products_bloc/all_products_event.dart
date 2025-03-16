part of 'all_products_bloc.dart';

sealed class AllProductsEvent extends Equatable {
  const AllProductsEvent();
}

class GetAllProductsEvent extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}

class SearchProductsEvent extends AllProductsEvent {
  final String query;
  const SearchProductsEvent({required this.query});
  @override
  List<Object?> get props => [query];
}