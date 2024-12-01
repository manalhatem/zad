import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';


enum BtnType {selected, unSelected , normal}
class CustomBtn extends StatelessWidget {
  final String title;
  final Function() onTap;
  final BtnType type;
  const CustomBtn({super.key, required this.title, required this.onTap , required this.type});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r11),side:
      type==BtnType.unSelected? const BorderSide(color: AppColors.greenColor):BorderSide.none),
      padding: EdgeInsets.symmetric(horizontal: width()*0.02,vertical: height()*0.019),
      color:type==BtnType.normal? Colors.white : type==BtnType.selected? AppColors.greenColor : Theme.of(context).cardColor,
      child: Text(title,style: TextStyle(
          color:type==BtnType.normal?  AppColors.orangeCol: type==BtnType.selected? Colors.white : AppColors.greenColor,
          fontSize: AppFonts.t12),),
    );
  }
}
