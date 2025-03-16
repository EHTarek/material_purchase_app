part of '../dependency_injection.dart';

void _externals() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(() => InternetConnectionChecker.instance)
    ..registerLazySingleton(() => Client())
    ..registerLazySingleton(() => JwtDecoder())
    ..registerLazySingleton(() => const FlutterSecureStorage());
}