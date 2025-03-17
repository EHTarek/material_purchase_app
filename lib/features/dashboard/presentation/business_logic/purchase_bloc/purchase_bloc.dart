import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_purchase_app/common/widgets/custom_snackbar_widget.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/purchase_request_param.dart';
import 'package:material_purchase_app/features/dashboard/domain/use_cases/purchase_usecase.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final GetPurchaseData getPurchaseData;
  final PurchaseRequest purchaseRequest;

  PurchaseBloc({
    required this.getPurchaseData, required this.purchaseRequest,
  }) : super(PurchaseInitial()) {
    on<GetPurchaseDataEvent>(_onGetPurchaseDataEvent);
    on<SearchPurchaseEvent>(_onSearchPurchaseEvent);
    on<PurchaseRequestEvent>(_onPurchaseRequestEvent);
  }

  List<DataEntity> allPurchase = [];
  MaterialPurchaseEntity materialPurchaseEntity = MaterialPurchaseEntity();

  Future<void> _onGetPurchaseDataEvent(GetPurchaseDataEvent event, Emitter<PurchaseState> emit) async {
    emit(PurchaseLoading());
    if(event.page == 1){
      allPurchase.clear();
      materialPurchaseEntity = MaterialPurchaseEntity();
    }
    final result = await getPurchaseData(params: event.page);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(PurchaseNoInternet());
          case const (TokenInvalid):
            return emit(PurchaseSessionOut());
          default:
            return emit(PurchaseError(message: failure.message));
        }
      },
      (purchase) {
        allPurchase.addAll(purchase.materialPurchaseList?.data ?? []);
        materialPurchaseEntity = purchase;
        return emit(PurchaseLoaded(materialPurchaseEntity: purchase, purchaseResult: allPurchase));
      }
    );
  }

  Future<void> _onSearchPurchaseEvent(SearchPurchaseEvent event, Emitter<PurchaseState> emit) async {
    emit(PurchaseLoading());
    List<DataEntity> searchResult = [];
    if(event.query.isNotEmpty && allPurchase.isNotEmpty){
      searchResult = allPurchase.where((element) {
        return element.lineItemName!.toLowerCase().contains(event.query.toLowerCase())
            || element.store!.toLowerCase().contains(event.query.toLowerCase())
            || element.runnersName!.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
    }else{
      searchResult = allPurchase;
    }
    emit(PurchaseSearchLoaded(materialPurchaseEntity: materialPurchaseEntity, searchResult: searchResult));
  }

  Future<void> _onPurchaseRequestEvent(PurchaseRequestEvent event, Emitter<PurchaseState> emit) async {
    emit(PurchaseLoading());
    final result = await purchaseRequest(params: event.param);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ConnectionFailure):
            return emit(PurchaseNoInternet());
          case const (TokenInvalid):
            return emit(PurchaseSessionOut());
          default:
            showCustomSnackBar(failure.message);
            return emit(PurchaseError(message: failure.message));
        }
      },
      (message) {
        showCustomSnackBar(message, isError: false);
        emit(PurchaseRequestSuccess(message: message));
        add(GetPurchaseDataEvent(page: 1));
      }
    );
  }
}
