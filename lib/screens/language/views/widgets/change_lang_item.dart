import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';

class ChangeLanguageItem extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool isArabic;
  const ChangeLanguageItem({super.key, this.onTap, required this.text, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Padding(
        padding: EdgeInsets.only(left: width()*0.04,right: width()*0.04,top: width()*0.04,bottom: width()*0.02),
        child: Row(
          children: [
            Text(text, style:
            isArabic?
            Theme.of(context).textTheme.displayMedium:
            Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            isArabic ?
            SvgPicture.asset(AppImages.check):const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
