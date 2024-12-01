import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';

import '../../../../core/utils/images.dart';

enum QuraanItemType{sowar,quarters,parts}
class QuraanItem extends StatelessWidget {
  final QuraanItemType type;
  final Function() onTap;
  final String title;
  final String? desc;
  final String? img;
  final String? num;
  const QuraanItem({super.key, required this.type, required this.onTap, required this.title,  this.desc,  this.img,  this.num});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(width()*0.02),
        decoration:  BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey
              )
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppImages.suraNum,scale: 2.5,),
                if(num!=null)
                Text(num!,style: TextStyle(fontSize: AppFonts.t10,color: AppColors.greenColor),),
              ],
            ),
            SizedBox(width: width()*0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: TextStyle(fontFamily: "Amiri" ,fontSize: AppFonts.t16,fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight),),
                  if(type!=QuraanItemType.parts)...[
                  SizedBox(height: height()*0.01,),
                  Text(desc!,style: TextStyle(fontSize: AppFonts.t12,color: AppColors.grayColor2,fontFamily: "Amiri" ),),]
                ],
              ),
            ),
          if(type==QuraanItemType.sowar)...[
            const Spacer(),
            Image.asset(img! ,scale: 3,)]
          ],
        ),
      ),
    );
  }
}
