part of '../dependency_injection.dart';

void _blocs() {
  sl
    ..registerFactory<AllProductsBloc>(() => AllProductsBloc(
      getProductsUseCase: sl(),
    ))
    ..registerFactory<CartCubit>(() => CartCubit(
      addToCartUseCase: sl(), removeFromCartUseCase: sl(),
      loadCartUseCase: sl(), clearCartUseCase: sl(),
      cartCheckoutUseCase: sl(),
    ))
    ..registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
      loginUseCase: sl(), logoutUseCase: sl(), getUserData: sl(),
    ))
    ..registerFactory<AuthenticationCubit>(() => AuthenticationCubit())
    ..registerFactory<PurchaseBloc>(() => PurchaseBloc(getPurchaseData: sl()));
}