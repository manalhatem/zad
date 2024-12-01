import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';

class CustomContainer extends StatelessWidget {
  final Widget body;

  const CustomContainer({super.key, required this.body});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [BoxShadow(
            color: AppColors.grayColor2.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
          )],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppRadius.r16),
              topLeft: Radius.circular(AppRadius.r16))),
      padding: EdgeInsets.symmetric(
          vertical: height() * 0.02,
          horizontal: width() * 0.03),
      child: body,
    );
  }
}
