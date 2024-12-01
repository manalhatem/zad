import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../generated/locale_keys.g.dart';
import 'custom_orange_btn.dart';

class CompleteListAzkar extends StatelessWidget {
  final dynamic Function() onTap;
  const CompleteListAzkar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: width() * .05),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.r8)),
        padding: EdgeInsets.symmetric(
            horizontal: width() * .06, vertical: height() * .04),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.completeList),
            SizedBox(height: height()*0.02),
            Text(
              LocaleKeys.canNotAddZekr.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: height() * .04,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomOrangeBtn(
                      title: LocaleKeys.remembranceList.tr(), onTap: onTap, type: BtnType.orange),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
