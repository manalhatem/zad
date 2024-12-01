import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/screens/btmNavBar/model/btm_nav_model.dart';

class CustomBtmNavItem extends StatelessWidget {
  final BottomNavModel model;
  const CustomBtmNavItem({super.key,required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: model.onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(model.image,color:!model.colored? const Color(0xff9EC38F):AppColors.orangeCol,scale: 3,),
          Text(model.title,style: TextStyle(fontSize: AppFonts.t12,color:!model.colored? const Color(0xff9EC38F):AppColors.orangeCol),)
        ],
      ),
    );
  }
}
