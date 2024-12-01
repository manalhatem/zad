import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';

class ChangeModeItem extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool light;
  const ChangeModeItem({super.key, this.onTap, required this.text, required this.light});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Padding(
        padding: EdgeInsets.only(left: width()*0.04,right: width()*0.04,top: width()*0.04,bottom: width()*0.02),
        child: Row(
          children: [
            Text(text, style:
            light?
            Theme.of(context).textTheme.displayMedium:
            Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            light ?
            SvgPicture.asset(AppImages.check):const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
