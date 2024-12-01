import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';

enum SoraBtnType { orange, green }

class CustomSoraBtn extends StatelessWidget {
  final Widget title;
  final Function() onTap;
  final SoraBtnType type;

  const CustomSoraBtn(
      {super.key,
      required this.title,
      required this.onTap,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: height() * 0.015),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r11),
          border: Border.all(color:type == SoraBtnType.orange ? AppColors.orangeCol : AppColors.greenColor )
          ),
          child: Center(
            child: title,
          ),
        ));
  }
}
