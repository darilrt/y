import 'package:flutter/material.dart';

enum AnimationOrientation {
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop,
}

class YPageRoute extends PageRouteBuilder {
  final Widget? page;
  final AnimationOrientation orientation;

  YPageRoute(
      {this.page,
      RouteSettings? settings,
      this.orientation = AnimationOrientation.rightToLeft})
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
            Animatable<Offset> tween;

            switch (orientation) {
              case AnimationOrientation.rightToLeft:
                tween = Tween<Offset>(
                  begin: const Offset(0.5, 0.0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.ease));
                break;

              case AnimationOrientation.leftToRight:
                tween = Tween<Offset>(
                  begin: const Offset(-0.5, 0.0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.ease));
                break;

              case AnimationOrientation.topToBottom:
                tween = Tween<Offset>(
                  begin: const Offset(0.0, -0.5),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.ease));
                break;

              case AnimationOrientation.bottomToTop:
                tween = Tween<Offset>(
                  begin: const Offset(0.0, 0.5),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.ease));
                break;
            }

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: tween.animate(animation),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 150),
          reverseTransitionDuration: const Duration(milliseconds: 150),
        );
}
