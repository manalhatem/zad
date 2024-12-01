import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/utils/my_navigate.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../generated/locale_keys.g.dart';

class ChangeAddress extends StatelessWidget {
  final void Function()? onTap;
  const ChangeAddress({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal:width()*0.07,vertical:width()*0.06),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.changeAddress.tr(),style: TextStyle(color: AppColors.greenColor,
              fontSize:AppFonts.t14 )),
          SizedBox(height: width()*0.04),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: width()*0.03,vertical:width()*0.033),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(AppRadius.r8)),
              child:  Row(
                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  CacheHelper.getData(key: AppCached.location)==null?
                  Text(
                      LocaleKeys.currentLocation.tr(),
                    style:TextStyle(color: AppColors.grayColor, fontSize: AppFonts.t10),
                  ): Text( CacheHelper.getData(key: AppCached.location),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),
              ), const Icon(Icons.gps_fixed_sharp,color: AppColors.greenColor)
                ],
              ),
              ),
          ),
          SizedBox(height: width()*0.05),
          Row(
            children: [
              Expanded(child: CustomBtn(title: LocaleKeys.saveAddress.tr(), onTap: (){
                navigatorPop();
              }, type: BtnType.selected)),
            ],
          ),

        ],
      ),
    );
  }
}
