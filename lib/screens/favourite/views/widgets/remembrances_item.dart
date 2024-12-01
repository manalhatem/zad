import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/widgets/custom_network_img.dart';

import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/dark_image.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';

class RemembrancesItem extends StatelessWidget {
  final String img;
  final String text;
  final int id;
  const RemembrancesItem({super.key, required this.img, required this.text, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: width()*0.01),
      child: Row(
        children: [
          CustomNetworkImg(img: img, width:  width()*0.13),
          SizedBox(width: width()*0.03),
          Text(text,style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),),
          const Spacer(),
          SvgPicture.asset(context.locale.languageCode=="ar"?
          CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
              ? DarkAppImages.arrowAr
              : AppImages.arrowAr:
          CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
              ? DarkAppImages.arrowEn : AppImages.arrowEn,width: width()*0.08),
        ],
      ),
    );
  }
}
