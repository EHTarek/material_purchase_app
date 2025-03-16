import 'package:material_purchase_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:material_purchase_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:material_purchase_app/features/on_boarding/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

part './parts/authentication_routes.dart';
part './parts/on_boarding_routes.dart';
part './parts/dashboard_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter get appRouteConfig => GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: Routes.initial,
  routes: [
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      builder: (context, state)=> SplashScreen(),
      // pageBuilder: (context, state) {
      //   return const NoTransitionPage(
      //     child: SplashScreen(),
      //   );
      // },
    ),
    ..._onboardingRoutes(),
    ..._authenticationRoutes(),
    ..._dashboardRoutes(),
  ],
);
