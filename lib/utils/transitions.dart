import 'package:flutter/widgets.dart';

class SlideRightTransition extends PageRouteBuilder {
  final Widget newScreen;
  SlideRightTransition({this.newScreen})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              newScreen,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class ScaleTransitionEffect extends PageRouteBuilder {
  final Widget newScreen;
  ScaleTransitionEffect({this.newScreen})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              newScreen,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.slowMiddle,
              ),
            ),
            child: child,
          ),
        );
}

class FadeRoute extends PageRouteBuilder {
  final Widget newScreen;
  FadeRoute({this.newScreen})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
          newScreen,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
