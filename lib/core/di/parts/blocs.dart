part of '../dependency_injection.dart';

void _blocs() {
  sl
    ..registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
      loginUseCase: sl(), logoutUseCase: sl(), getUserData: sl(),
    ))
    ..registerFactory<AuthenticationCubit>(() => AuthenticationCubit())
    ..registerFactory<PurchaseBloc>(() => PurchaseBloc(getPurchaseData: sl()));
}