part of '../router.dart';

List<GoRoute> _authenticationRoutes() {
  return [
    GoRoute(
      path: Routes.login,
      name: Routes.login,
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginScreen());
      },
    ),
  ];
}
