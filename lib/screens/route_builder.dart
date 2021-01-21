import 'package:flutter/material.dart';

Route buildRoute(
  Widget child, {
  Offset begin = const Offset(1.0, 0.0),
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final end = Offset.zero;
      final curve = Curves.ease;

      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
