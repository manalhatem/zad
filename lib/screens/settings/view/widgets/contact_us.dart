import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  final String whatsapp,website;

  const ContactUs({super.key, required this.whatsapp, required this.website});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:width()*0.07,vertical:width()*0.06),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.contactThrough.tr(),style: TextStyle(color: AppColors.greenColor,
              fontSize:AppFonts.t14 ),),
          SizedBox(height: width()*0.04),
          Row(
            children: [
              Expanded(child: CustomBtn(title: LocaleKeys.throughWhats.tr(), onTap: (){
                launchUrl(Uri.parse(whatsapp),mode: LaunchMode.externalApplication);
              }, type: BtnType.selected)),
            ],
          ),
          SizedBox(height: width()*0.01),
          Row(
            children: [
              Expanded(child: CustomBtn(title: LocaleKeys.throughWebsite.tr(), onTap: (){
                launchUrl(Uri.parse(website),mode: LaunchMode.externalApplication);}, type: BtnType.unSelected)),
            ],
          ),
        ],
      ),
    );
  }
}
