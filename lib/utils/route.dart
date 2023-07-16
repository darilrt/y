import 'package:flutter/material.dart';

class YPageRoute extends PageRouteBuilder {
  final Widget? page;

  YPageRoute({this.page, settings})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return page ?? Container();
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.5, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 150),
          reverseTransitionDuration: const Duration(milliseconds: 150),
        );
}
