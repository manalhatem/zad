import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';

class BtmSheetHeader extends StatelessWidget {
  final String title;

  const BtmSheetHeader({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        // InkWell(
        //   child: Text(
        //     LocaleKeys.saveVal.tr(),
        //     style: TextStyle(
        //         color: AppColors.orangeCol, fontSize: AppFonts.t14),
        //   ),
        // ),
        Text(
          title,
          style: TextStyle(
              color: AppColors.greenColor, fontSize: AppFonts.t12,fontFamily: "Amiri"),
        ),
        InkWell(
          onTap: () {
            navigatorPop( );
          },
          child: Text(
            LocaleKeys.cancelVal.tr(),
            style: TextStyle(
                color: AppColors.grayColor2, fontSize: AppFonts.t14),
          ),
        ),
      ],
    );
  }
}
