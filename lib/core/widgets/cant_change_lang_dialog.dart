import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import '../../screens/sabha/views/widgets/custom_orange_btn.dart';
import '../../screens/splash/view/splash_view.dart';
import '../utils/my_navigate.dart';
import '../utils/size.dart';

class CantChangeLangDialog extends StatelessWidget {
  const CantChangeLangDialog({super.key});

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
              "This feature in the application is available in Arabic only and is not available in English.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: height() * .04,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomOrangeBtn(
                      title: "Change language", onTap: (){
                    context.setLocale(const Locale("ar"));
                    navigateAndFinish(widget:const SplashScreen());
                  }, type: BtnType.orange),
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
