import 'package:flutter/material.dart';
import 'package:zad/core/widgets/custom_background.dart';
import '../utils/size.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding({super.key, required this.widget, this.withPattern});

  final Widget widget;
  final bool? withPattern;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child:withPattern==true?
      CustomBackground(widget: Padding(
        padding: EdgeInsets.symmetric(horizontal: width() * .03),
        child: widget,
      ),):
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width() * .03),
        child: widget,
      ),
    );
  }
}
