import 'package:flutter/material.dart';
import 'package:zad/main.dart';
import '../widgets/custom_padding.dart';

/// Navigator Push

void navigateToWithPadding({required widget,reloadMethod}) =>
    Navigator.push(
        navigatorKey.currentContext!,
        PageRouteBuilder(
          barrierColor: Colors.transparent,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CustomPadding(
              widget: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return widget;
          },
        )).then(reloadMethod ?? (value){});

void navigateTo({required widget}) =>
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

/// Navigator Finish
navigateAndFinish({required widget}) =>
    Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (ctx) => widget),
        (Route<dynamic> route) => false);

/// Navigator Pop

navigatorPop() => Navigator.pop(navigatorKey.currentContext!);

/// Navigator And Replace
navigateAndReplace({  required widget}) =>
    Navigator.pushReplacement(
        navigatorKey.currentContext!,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          barrierColor: Colors.transparent,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return widget;
          },
        ));
