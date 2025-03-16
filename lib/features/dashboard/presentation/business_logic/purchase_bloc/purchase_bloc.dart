import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';
import 'package:material_purchase_app/features/dashboard/domain/use_cases/purchase_usecase.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final GetPurchaseData getPurchaseData;
  PurchaseBloc({required this.getPurchaseData}) : super(PurchaseInitial()) {
    on<GetPurchaseDataEvent>(_onGetPurchaseDataEvent);
  }


  Future<void> _onGetPurchaseDataEvent(GetPurchaseDataEvent event, Emitter<PurchaseState> emit) async {
    emit(PurchaseLoading());
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
        return emit(PurchaseLoaded(materialPurchaseEntity: purchase));
      }
    );
  }
}
