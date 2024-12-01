import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/main.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import 'custom_compass.dart';

class QiblaBody extends StatefulWidget {
  const QiblaBody({super.key});

  @override
  State<QiblaBody> createState() => _QiblaBodyState();
}

class _QiblaBodyState extends State<QiblaBody> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) => showDialog(context: navigatorKey.currentContext!, builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: PopScope(
        canPop: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.qiblaLoading),
            Text(LocaleKeys.infQibla.tr(),style: TextStyle(
                fontSize: AppFonts.t14,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height()*0.02),
              child: Text(LocaleKeys.qiblaSubTit.tr(),style: TextStyle(
                  fontSize: AppFonts.t14,
                  color: Colors.grey
              ),textAlign: TextAlign.center,),
            ),
            MaterialButton(
              onPressed: () => navigatorPop(),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r8)),
              padding: EdgeInsets.symmetric(horizontal: width()*0.2),
              color:AppColors.orangeCol,
              child: Text(LocaleKeys.done.tr(),style: TextStyle(
                  color:Colors.white,
                  fontSize: AppFonts.t12),),
            ),
          ],
        ),
      ),
    ),));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPadding(
        withPattern: true,
        widget:Column(
          children: [
            CustomAppBar(text: LocaleKeys.qibla.tr()),
            SizedBox(height: height()*0.18),
             const CustomCompass(),
          ],
        ),
      ),
    );
  }
}
