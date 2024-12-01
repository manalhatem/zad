import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';

import '../utils/colors.dart';

class OrangeRow extends StatelessWidget {
  final Function() aPlusOnTap , aMinusOnTap, originalFont;
  final String text;

   OrangeRow({super.key, required this.aPlusOnTap, required this.aMinusOnTap, required this.text, required this.originalFont});
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      key:scaffoldKey ,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(AppRadius.r11)
      ),
      padding: EdgeInsets.symmetric(horizontal: width()*0.05,vertical: height()*0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: aPlusOnTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("+A",style: TextStyle(fontSize: AppFonts.t16,color: Colors.white),),
            ),
          ),
          InkWell(
            onTap: originalFont,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("A",style: TextStyle(fontSize: AppFonts.t16,color: Colors.white),),
            ),
          ),
          InkWell(
            onTap: aMinusOnTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("-A",style: TextStyle(fontSize: AppFonts.t16,color: Colors.white),),
            ),
          ),
          InkWell(
            onTap: ()async{
              await Clipboard.setData(ClipboardData(text: text.toString()));
              ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
                  SnackBar(content:Text(LocaleKeys.textCopied.tr()),duration: const Duration(seconds: 1),backgroundColor: AppColors.greenColor,));
            },
            child: SvgPicture.asset(AppImages.whiteCopy),
          ),
          InkWell(
            onTap: ()async{
              await Share.share(
                text,
              );
            },
            child: SvgPicture.asset(AppImages.whiteShare),
          ),
        ],
      ),
    );
  }
}
