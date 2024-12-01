import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/dark_image.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';

class SavedRow extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String subTitle;
  final String img;
  const SavedRow({super.key, this.onTap, required this.title, required this.subTitle, required this.img});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(img),
          SizedBox(width: width()*0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14)),
              Text(subTitle,style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: AppFonts.t10,fontFamily: "Amiri"),),
            ],
          ),
          const Spacer(),
          SvgPicture.asset(context.locale.languageCode=="ar"?
          CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
              ? DarkAppImages.arrowAr
              : AppImages.arrowAr:
          CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
              ? DarkAppImages.arrowEn : AppImages.arrowEn,width: width()*0.07),
        ],
      ),
    );
  }
}
