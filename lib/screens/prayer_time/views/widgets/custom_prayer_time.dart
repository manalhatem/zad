import 'package:flutter/material.dart';
import '../../../../core/utils/size.dart';

class CustomPrayerTime extends StatelessWidget {
  final String img;
  final String time;
  final String name;
  final Color col;
  final Color textClr;
  const CustomPrayerTime({super.key, required this.img, required this.time, required this.name, required this.col,required this.textClr});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal:width()*0.05,vertical:width()*0.028),
      margin: EdgeInsetsDirectional.symmetric(horizontal:width()*0.02,vertical:width()*0.018),
      decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.circular(AppRadius.r11)
      ),
      child: Row(
        children: [
          Image.asset(img,width: width()*0.1),
          SizedBox(width: width()*0.025),
          Text(name, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: AppFonts.t14,color: textClr)),
          const Spacer(),
          Text(time, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: AppFonts.t14,color: textClr))
        ],
      ),
    );
  }
}
