import 'package:campus_navigation/admin/dashboard/emergencies_page.dart';
import 'package:campus_navigation/admin/dashboard/home_page.dart';
import 'package:campus_navigation/admin/dashboard/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../admin/auth/views/login_page.dart';
import '../admin/dashboard/dashboard_contact_page.dart';
import '../admin/dashboard/locations_page.dart';
import 'router_items.dart';

class MyRouter {
  final WidgetRef ref;
  final BuildContext context;
  MyRouter({
    required this.ref,
    required this.context,
  });
  router() => GoRouter(
          initialLocation: RouterItem.loginRoute.path,
          redirect: (context, state) {
            var route = state.fullPath;
            //check if widget is done building
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (route != null && route.isNotEmpty) {
                var item = RouterItem.getRouteByPath(route);
                ref.read(routerProvider.notifier).state = item.name;
              }
            });
            return null;
          },
          routes: [
            GoRoute(
                path: RouterItem.loginRoute.path,
                builder: (context, state) {
                  return const LoginPage();
                }),
            ShellRoute(
                builder: (context, state, child) {
                  return DashboardMain(
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                      path: RouterItem.dashboardRoute.path,
                      builder: (context, state) {
                        return const DashboardHome();
                      }),
                  GoRoute(
                      path: RouterItem.emergenciesRoute.path,
                      builder: (context, state) {
                        return const EmergenciesPage();
                      }),
                  GoRoute(
                      path: RouterItem.contactsRoute.path,
                      builder: (context, state) {
                        return const DashboardContactPage();
                      }),
                  GoRoute(
                      path: RouterItem.locationsRoute.path,
                      builder: (context, state) {
                        return const LocationsPage();
                      })
                ])
          ]);

  void navigateToRoute(RouterItem item) {
    ref.read(routerProvider.notifier).state = item.name;
    context.go(item.path);
  }

  void navigateToNamed(
      {required Map<String, String> pathPrams,
      required RouterItem item,
      Map<String, dynamic>? extra}) {
    ref.read(routerProvider.notifier).state = item.name;
    context.goNamed(item.name, pathParameters: pathPrams, extra: extra);
  }
}

final routerProvider = StateProvider<String>((ref) {
  return RouterItem.loginRoute.name;
});
