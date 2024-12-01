import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/widgets/custom_network_img.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/dark_image.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';

class CustomRow extends StatelessWidget {
  final String img;
  final String text;
  final void Function()? onTap;
  final bool networkImg;
  const CustomRow({super.key, required this.img, required this.text, this.onTap, required this.networkImg});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: width()*0.01),
        child: Row(
          children: [
            networkImg == true?
            CustomNetworkImg(img: img, width: width()*0.12):
            SvgPicture.asset(img,width:  width()*0.12),
            SizedBox(width: width()*0.03),
            SizedBox(width:width()*0.7,
                child: Text(text,style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),)),
            const Spacer(),
            SvgPicture.asset(context.locale.languageCode=="ar"?
            CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                ? DarkAppImages.arrowAr
                : AppImages.arrowAr:
            CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                ? DarkAppImages.arrowEn : AppImages.arrowEn,width: width()*0.07),
          ],
        ),
      ),
    );
  }
}
