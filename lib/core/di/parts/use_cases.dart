part of '../dependency_injection.dart';

void _useCases() {
  sl
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => GetUserData(sl()))
    ..registerLazySingleton(() => CartCheckout(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => AddToCart(sl()))
    ..registerLazySingleton(() => LoadCart(sl()))
    ..registerLazySingleton(() => ClearCart(sl()))
    ..registerLazySingleton(() => RemoveFromCart(sl()))
    ..registerLazySingleton(() => GetPurchaseData(sl()));
}