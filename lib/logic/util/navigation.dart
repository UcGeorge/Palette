import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> actionSheetNav<T>(BuildContext context,
    {required Widget child}) async {
  final route = PageRouteBuilder<T>(
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(.2),
    fullscreenDialog: false,
    opaque: false,
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) =>
        child,
    transitionsBuilder: (_, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
  return await Navigator.of(context).push<T>(route);
}

Future<T?> alertNav<T>(BuildContext context, {required Widget child}) async {
  final route = PageRouteBuilder<T>(
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    fullscreenDialog: false,
    opaque: false,
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) =>
        child,
    transitionsBuilder: (_, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
  return await Navigator.of(context).push<T>(route);
}

Future<T?> cupertinoPageNav<T>(BuildContext context,
    {required Widget child}) async {
  final route = CupertinoPageRoute<T>(
    builder: (_) => child,
  );
  return await Navigator.of(context).push<T>(route);
}

Future<T?> materialPageNav<T>(BuildContext context,
    {required Widget child}) async {
  final route = MaterialPageRoute<T>(
    builder: (_) => child,
  );
  return await Navigator.of(context).push<T>(route);
}
