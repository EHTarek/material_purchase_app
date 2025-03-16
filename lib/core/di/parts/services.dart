part of '../dependency_injection.dart';

void _services() {
  sl.registerLazySingleton<TokenService>(() => TokenServiceImpl(
    preferences: sl(), client: sl(),
  ));
}