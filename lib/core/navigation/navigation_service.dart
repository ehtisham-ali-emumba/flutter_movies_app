import 'package:flutter/material.dart';
import 'app_router.dart';

/// A service that handles navigation throughout the app
class NavigationService {
  /// Global key used to access the navigator state
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to a named route
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Replace the current route with a new route
  Future<dynamic> replaceTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Pop to a specific route, removing all routes in between
  Future<dynamic> popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
    return Future.value(true);
  }

  /// Go back to the previous screen
  void goBack() {
    navigatorKey.currentState!.pop();
  }

  bool canGoBack() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  /// Navigate to a route without animation using a widget (legacy support)
  Future<dynamic> navigateWithoutAnimation(Widget screen) {
    return navigatorKey.currentState!.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  /// Navigate to a named route without animation
  Future<dynamic> navigateToWithoutAnimation(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.push(
      PageRouteBuilder(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) {
          return AppRouter.buildPageForRoute(routeName, arguments);
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  /// Replace the current route with a new route without animation
  Future<dynamic> replaceToWithoutAnimation(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) {
          return AppRouter.buildPageForRoute(routeName, arguments);
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  /// Replace the current route with a widget without animation (for legacy support)
  Future<dynamic> replaceWithWidgetWithoutAnimation(Widget screen) {
    return navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
