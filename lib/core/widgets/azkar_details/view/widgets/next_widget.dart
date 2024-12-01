import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/size.dart';



class NextWidget extends StatelessWidget {
  final PageController controller;
  final int currentIndex;
  final int length;
  const NextWidget({super.key, required this.controller, required this.currentIndex, required this.length});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap:(){
              controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
            child: SvgPicture.asset(AppImages.backward,width: width()*0.1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width()*0.02),
          child: Text(
             "${currentIndex+1}/$length" ,style: TextStyle(fontSize: AppFonts.t14,color: AppColors.grayColor2),),
        ),
        InkWell(
            onTap: (){
              controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
            child: SvgPicture.asset(AppImages.forward,width: width()*0.1,)),
      ],
    );
  }
}
