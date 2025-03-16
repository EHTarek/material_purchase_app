part of '../dependency_injection.dart';

void _core(){
  sl
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()))
    ..registerLazySingleton<Preferences>(() => PreferencesImpl(prefs: sl(), secureStorage: sl()))
    ..registerLazySingleton<Log>(() => LogImpl())
    ..registerLazySingleton(() => ApiClient(
      tokenService: sl(), prefs: sl(), log: sl(), networkInfo: sl(),
    ));
}