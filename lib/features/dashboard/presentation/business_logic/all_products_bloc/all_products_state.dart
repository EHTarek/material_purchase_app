part of 'all_products_bloc.dart';

sealed class AllProductsState extends Equatable {
  const AllProductsState();
}

final class AllProductsInitial extends AllProductsState {
  @override
  List<Object> get props => [];
}

final class AllProductsLoading extends AllProductsState {
  @override
  List<Object> get props => [];
}

final class AllProductsLoaded extends AllProductsState {
  final List<ProductsEntity> products;
  const AllProductsLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

final class AllProductsError extends AllProductsState {
  final String message;
  const AllProductsError({required this.message});
  @override
  List<Object> get props => [message];
}

final class AllProductsNoInternet extends AllProductsState {
  @override
  List<Object> get props => [];
}

final class AllProductsSessionOut extends AllProductsState {
  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends AllProductsState {
  @override
  List<Object> get props => [];
}

final class SearchProductLoaded extends AllProductsState {
  final List<ProductsEntity> products;
  const SearchProductLoaded({required this.products});
  @override
  List<Object> get props => [products];
}
