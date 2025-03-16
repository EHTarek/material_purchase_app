part of '../dependency_injection.dart';

void _repositories(){
  sl
    ..registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl(),
    ))
    ..registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(
      remote: sl(), networkInfo: sl(), local: sl(),
    ));
}