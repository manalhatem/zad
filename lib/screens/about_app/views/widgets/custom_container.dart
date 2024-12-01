import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';

class CustomStaticContainer extends StatelessWidget {
  final Widget widget;
  const CustomStaticContainer({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width(),
    padding: EdgeInsetsDirectional.symmetric(vertical: width()*0.05,horizontal:width()*0.05 ),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.r8),
    color: AppColors.greenColor.withOpacity(.05)
    ),
    child: widget);
  }
}
