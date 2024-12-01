import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zad/core/utils/my_navigate.dart';

import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/dark_image.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import 'show_video_in_app.dart';

class MultiMediaDetailsItem extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  final bool isFav;
  final String media;
  final String type;
  final void Function()? onTapFav;
  const MultiMediaDetailsItem({super.key, required this.img, required this.title, required this.subTitle, required this.isFav, required this.media, required this.type, this.onTapFav});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:type=='link'? ()async {
        if (!await launchUrl(Uri.parse(media))) {
          throw 'Could not launch';
        } else {
          return  ;
        }
      }:(){
        navigateTo(widget: ShowVideoInApp(path: media, title: title));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppRadius.r8),
            border: Border.all(color: AppColors.grayColor.withOpacity(.5)),
            boxShadow: [
                 BoxShadow(
              color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                  blurRadius: 10,
             offset: const Offset(2, 2), // changes position of shadow
      ),]
        ),
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Stack(
              alignment : AlignmentDirectional.center,
              children: [
                Container(
                  height: height()*0.14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(AppRadius.r8),topRight:Radius.circular(AppRadius.r8)),
                      image:  DecorationImage(image: NetworkImage(img),fit: BoxFit.fill)
                  ),
                ),
                SvgPicture.asset(AppImages.video)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: width()*0.02,horizontal: width()*0.02 ),
              child: Row(
                children: [
                  SizedBox(
                    width:width()*0.3,
                    child: Text(title,style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14,
                        fontFamily: "BEIN"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onTapFav,
                    child: SvgPicture.asset(
                        isFav == true ? AppImages.fav:
                        CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme?
                        DarkAppImages.nofavDark:
                        AppImages.noFav,width: width()*0.09),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: width()*0.02,start:width()*0.02,end: width()*0.02, ),
              child: SizedBox(
                width:width()*0.4,
                child: Text(subTitle,style: TextStyle(color: AppColors.orangeCol,fontSize: AppFonts.t12,
                    fontFamily: "BEIN"),maxLines: 2,overflow: TextOverflow.ellipsis,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
