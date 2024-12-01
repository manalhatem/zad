import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/size.dart';


class TextContainer extends StatelessWidget {
  final String text;
  final double fontSize;
  const TextContainer({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width(),
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(vertical: height()*0.03),
      padding: EdgeInsets.symmetric(horizontal: width()*0.02,vertical: height()*0.02),
      decoration: BoxDecoration(
          color: AppColors.greenColor.withOpacity(.08),
          borderRadius: BorderRadius.circular(AppRadius.r11)
      ),
      child: Text(text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: "Amiri",
            height: 3,
            color: Theme.of(context).primaryColorLight
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
