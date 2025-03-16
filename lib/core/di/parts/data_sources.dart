part of '../dependency_injection.dart';

void _dataSources() {
  sl
    ..registerLazySingleton<DashboardRemoteDataSource>(() => DashboardRemoteDataSourceImpl(
      client: sl(),
    ))
    ..registerLazySingleton<DashboardLocalDataSource>(() => DashboardLocalDataSourceImpl(
      prefs: sl(),
    ))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationDataRemoteSourceImpl(
      client: sl(), prefs: sl(), tokenService: sl(),
    ))
    ..registerLazySingleton<AuthenticationLocalDataSource>(() => AuthenticationLocalDataSourceImpl(
      prefs: sl(),
    ));
}