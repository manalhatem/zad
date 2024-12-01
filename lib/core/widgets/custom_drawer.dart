import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_btn.dart';
import 'package:zad/generated/locale_keys.g.dart';

class CustomDrawer extends StatelessWidget {
  final dynamic Function() onTap;
  final bool fromHome;


  const CustomDrawer({super.key, required this.onTap, required this.fromHome,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:fromHome==true? EdgeInsetsDirectional.only(start: width()*0.1):EdgeInsetsDirectional.symmetric(horizontal: width()*0.02,vertical:width()*0.015 ),
      padding:fromHome==true? EdgeInsets.symmetric(horizontal: width()*0.02,vertical: height()*0.01):
      EdgeInsets.symmetric(horizontal: width()*0.025,vertical: height()*0.018),
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage(AppImages.orangeBg),fit: BoxFit.fill,),
        borderRadius:fromHome==true? BorderRadiusDirectional.only(
          topStart: Radius.circular(AppRadius.r11),
          bottomStart: Radius.circular(AppRadius.r11)
        ):
            BorderRadius.circular(AppRadius.r11)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fromHome==true?  Text(LocaleKeys.choseAndListen.tr(),style: TextStyle(color: Colors.white,fontSize: AppFonts.t14),):const SizedBox.shrink(),
          SizedBox(height: height()*0.01,),
          Row(
            children: [
              Expanded(
                child: Text(LocaleKeys.newFeature.tr(),
                  style: TextStyle(color: Colors.white,fontSize: AppFonts.t10),),
              ),
              SizedBox(width: width()*0.01),
              CustomBtn(title: fromHome==true ?LocaleKeys.choseAndListen.tr(): LocaleKeys.addNewPlayList.tr(), onTap:onTap,type: BtnType.normal)
            ],
          )
        ],
      ),
    );
  }
}
