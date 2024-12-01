import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';

class VideoFavItem extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  final String type;
  final void Function()? onTapFav;
  final bool isFav;

  const VideoFavItem({super.key, required this.img, required this.title, required this.subTitle, this.onTapFav, required this.isFav, required this.type});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppRadius.r8),
          border: Border.all(color: AppColors.grayColor.withOpacity(.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
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
                      isFav==true? AppImages.fav:AppImages.noFav,width: width()*0.09),
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
    );
  }
}
