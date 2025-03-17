part of '../dependency_injection.dart';

void _useCases() {
  sl
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => GetUserData(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => GetPurchaseData(sl()))
    ..registerLazySingleton(() => PurchaseRequest(sl()));
}