import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/utils/my_navigate.dart';
import '../utils/images.dart';
import '../utils/size.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? clr;
  final bool? withBack;
  final EdgeInsetsGeometry? padding;
  final Widget? endWidget ;

  const CustomAppBar({super.key, required this.text, this.onTap, this.clr, this.withBack=true, this.padding, this.endWidget});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: clr==null ?null : Theme.of(context).scaffoldBackgroundColor,
      padding:padding??  EdgeInsets.only(top:width()*0.1,bottom:width()*0.05 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          withBack==true?
          GestureDetector(
            onTap:onTap ?? (){navigatorPop();},
            child:
            context.locale.languageCode=="ar"?
            SvgPicture.asset(AppImages.greenArrow,width: width()*0.1):
            RotatedBox(quarterTurns: 2,
             child: SvgPicture.asset(AppImages.greenArrow,width: width()*0.1)),
          ):SizedBox(width: width()*0.11,height: width()*0.1),
          Flexible(child: Center(child: Text(text, style: Theme.of(context).textTheme.titleMedium,maxLines: 2,textAlign: TextAlign.center,))),
         endWidget ?? SizedBox(width: width()*0.11)
        ],

      ),
    );
  }
}
