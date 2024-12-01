import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/my_navigate.dart';
import '../../../../core/utils/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../sabha/views/widgets/custom_orange_btn.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog ({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Text(
              "هل أنت متأكد من حذف هذا الورد ؟",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: height() * .04,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomOrangeBtn(
                      title: LocaleKeys.delete.tr(), onTap: (){}, type: BtnType.orange),
                ),
                SizedBox(
                  width: width() * .03,
                ),
                Expanded(
                  child: CustomOrangeBtn(
                      title: LocaleKeys.cancelVal.tr(), onTap: () { navigatorPop( ); }, type: BtnType.opacityOrange),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
