import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';

import '../../controller/home_cubit.dart';

class QuraanBenefit extends StatelessWidget {
   const QuraanBenefit({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
      HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height() * 0.02),
            child: Text(LocaleKeys.quranicBenfit.tr(), style: TextStyle(
                fontSize: AppFonts.t14, color: AppColors.greenColor),),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: height() * 0.01),
            padding: EdgeInsets.symmetric(
                vertical: height() * 0.02, horizontal: width() * 0.02),
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .cardColor,
                borderRadius: BorderRadius.circular(AppRadius.r11)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height() * 0.02,),
                Text(cubit.quranicBenefitsModel!.ayahName.toString(),
                  style: TextStyle(fontSize: AppFonts.t16,
                      fontFamily: "Amiri",
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .primaryColorLight),),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height() * 0.01),
                  child: Text("[${cubit.quranicBenefitsModel!.surahName.toString()}:${cubit.quranicBenefitsModel!.ayahNumber.toString()}]", style: TextStyle(
                      fontSize: AppFonts.t10, color: AppColors.greenColor),),
                ),
                Text(cubit.quranicBenefitsModel!.benefit.toString(),
                  style: TextStyle(
                      color: AppColors.grayColor2, fontSize: AppFonts.t12),
                ),
                Row(
                  children: [
                    Text(cubit.quranicBenefitsModel!.name.toString(), style: TextStyle(
                        color: AppColors.orangeCol, fontSize: AppFonts.t12),),
                    const Spacer(),
                    InkWell(
                        onTap: ()async{
                          await Share.share(
                            cubit.quranicBenefitsModel!.ayahName.toString(),
                          );
                        },
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Showcase(
                            key: cubit.four,description: LocaleKeys.toShare.tr(),
                            descTextStyle: TextStyle(fontSize: AppFonts.t16),
                            child: SvgPicture.asset(AppImages.shareIcn))),
                    SizedBox(width: width() * 0.02,),
                    InkWell(
                        onTap: ()async{
                          await Clipboard.setData(ClipboardData(text: cubit.quranicBenefitsModel!.ayahName.toString()));
                          showToast(text: LocaleKeys.textCopied.tr(), state: ToastStates.success);
                        },
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Showcase(key: cubit.five,description: LocaleKeys.toCopy.tr(),
                            descTextStyle: TextStyle(fontSize: AppFonts.t16),child: SvgPicture.asset(AppImages.copyIcn))),
                  ],
                ),
              ],
            ),
          ),

        ],
      );
    });
  }
}
