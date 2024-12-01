import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';

class AboutContributorsItem extends StatelessWidget {
  final String img;
  final String name;
  final String subTitle;
  const AboutContributorsItem({super.key, required this.img, required this.name, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: width()*0.03, vertical: width()*0.04),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r8),
          color: AppColors.greenColor.withOpacity(.05)
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppRadius.r25,
            backgroundImage:  NetworkImage(img),
          ),
          SizedBox(width: width()*0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: Theme.of(context).textTheme.titleMedium),
              Text(subTitle,style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t10),),
            ],
          )
        ],
      ),
    );
  }
}
