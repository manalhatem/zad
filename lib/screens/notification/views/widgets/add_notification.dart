import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/my_navigate.dart';
import '../../../../core/utils/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../add_new_notification/views/add_new_notify_view.dart';

class AddNewNotify extends StatelessWidget {
  const AddNewNotify({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo( widget:  const AddNewNotification());
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: width()*0.04,horizontal:width()*0.024),
          decoration: BoxDecoration(
              border: Border.all(color:Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(AppRadius.r8)
          ),
          child: Row(
            children: [
              Text(LocaleKeys.addNewNotify.tr(), style: TextStyle(color: AppColors.orangeCol,fontSize: AppFonts.t14)),
              const Spacer(),
              SvgPicture.asset(AppImages.add),
            ],
          )),
    );
  }
}
