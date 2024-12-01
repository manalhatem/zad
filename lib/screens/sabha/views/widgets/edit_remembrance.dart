import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../generated/locale_keys.g.dart';

class EditRemembrance extends StatelessWidget {
  const EditRemembrance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width()*0.48,
      alignment: AlignmentDirectional.center,
      padding: EdgeInsetsDirectional.symmetric(horizontal: width()*0.02,vertical:width()*0.02),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8))
      ),
      child: Column(
        children: [
          InkWell(
            onTap: (){},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(LocaleKeys.editRemembrance.tr(),style: TextStyle(color: AppColors.orangeCol,fontSize: AppFonts.t14),),
                SizedBox(width: width()*0.02,),
                SvgPicture.asset(AppImages.edit)
              ],),
          ),
          Divider(color: AppColors.grayColor2.withOpacity(0.2)),
          InkWell(
            onTap: (){},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(LocaleKeys.removeRemembrance.tr(),style: TextStyle(color: AppColors.redCol,fontSize: AppFonts.t14),),
                SizedBox(width: width()*0.02,),
                SvgPicture.asset(AppImages.trash)
              ],),
          )
        ],
      ),
    )
    ;
  }
}
