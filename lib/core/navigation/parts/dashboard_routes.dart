part of '../router.dart';

List<GoRoute> _dashboardRoutes() {
  return [
    GoRoute(
      path: Routes.homeTab,
      name: Routes.homeTab,
      pageBuilder: (context, state) {
        return const MaterialPage(child: DashboardScreen());
      },
    ),
  ];
}
