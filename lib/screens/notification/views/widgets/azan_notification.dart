import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';

class AzanNotificationItem extends StatelessWidget {
  final String title;
  final bool isEnable;
  final Function() onTap;

  const AzanNotificationItem({super.key, required this.title, required this.isEnable, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: width()*0.035),
        titleAlignment:ListTileTitleAlignment.top ,
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        trailing: GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(isEnable? AppImages.active:AppImages.notActive)),
      );
  }
}