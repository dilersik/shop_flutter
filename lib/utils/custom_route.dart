import 'package:flutter/material.dart';
import 'package:shop_flutter/utils/app_pages.dart';

class CustomRoute<T> extends MaterialPageRoute {
  CustomRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == AppPages.authOrHome) {
      return child;
    }
    return FadeTransition(opacity: animation, child: child);
  }
}

class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == AppPages.authOrHome) {
      return child;
    }
    return FadeTransition(opacity: animation, child: child);
  }
}
