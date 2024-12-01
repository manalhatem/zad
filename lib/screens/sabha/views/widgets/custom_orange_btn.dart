import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';


enum BtnType {orange,opacityOrange}
class CustomOrangeBtn extends StatelessWidget {
  final String title;
  final Function() onTap;
  final BtnType type;
  const CustomOrangeBtn({super.key, required this.title, required this.onTap , required this.type});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r11)),
      padding: EdgeInsets.symmetric(horizontal: width()*0.02,vertical: height()*0.019),
      color:type==BtnType.orange ?AppColors.orangeCol:const Color(0xffFDEDDA),
      child: Text(title,style: TextStyle(
          color: type==BtnType.orange ?Colors.white:AppColors.orangeCol,
          fontSize: AppFonts.t12),),
    );
  }
}
