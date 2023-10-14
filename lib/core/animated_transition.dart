import 'package:flutter/material.dart';

class AnimatedTransition extends PageRouteBuilder {
  Widget page;
  AnimatedTransition({required this.page})
      : super(
            pageBuilder: (context, animation, anim2) => page,
            transitionsBuilder: (context, animation, anim2, widget) {
              var tween = Tween<double>(begin: 0.0, end: 1.0);

              // var positionAnimation =  animation.drive(tween);
              var curve = CurvedAnimation(
                  parent: animation, curve: Curves.easeInOutCubicEmphasized);
              var positionAnimation = tween.animate(curve);

              return ScaleTransition(
                  scale: positionAnimation,
                  child: widget);
            });
}