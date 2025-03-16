import 'package:material_purchase_app/core/base/empty_param.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/products_entity.dart';
import 'package:material_purchase_app/features/dashboard/domain/use_cases/products_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final GetProducts getProductsUseCase;

  AllProductsBloc({required this.getProductsUseCase}) : super(AllProductsInitial()) {
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<SearchProductsEvent>(_onSearchProductsEvent);
  }

  final List<ProductsEntity> allProducts = [];

  Future<void> _onGetAllProductsEvent(GetAllProductsEvent event, Emitter<AllProductsState> emit) async {
    emit(AllProductsLoading());
    final result = await getProductsUseCase(params: EmptyParam());
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(AllProductsNoInternet());
          case const (TokenInvalid):
            return emit(AllProductsSessionOut());
          default:
            return emit(AllProductsError(message: failure.message));
        }
      },
      (products) {
        allProducts.addAll(products);
        return emit(AllProductsLoaded(products: products));
      }
    );
  }

  Future<void> _onSearchProductsEvent(SearchProductsEvent event, Emitter<AllProductsState> emit) async {
    emit(SearchProductInitial());
    List<ProductsEntity> searchResult = [];
    if(event.query.isNotEmpty && allProducts.isNotEmpty){
      searchResult = allProducts.where((element) {
        return element.name!.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
    }else{
      searchResult = allProducts;
    }
    emit(SearchProductLoaded(products: searchResult));
  }
}
