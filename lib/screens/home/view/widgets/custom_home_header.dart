import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../qibla/views/qibla_view.dart';
import '../../controller/home_cubit.dart';
import 'count_down.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(
        builder: (context,state) {
      final cubit = BlocProvider.of<HomeCubit>(context);
      return Column(
        children: [
          Row(
            children: [
              Showcase(key: cubit.one, description: LocaleKeys.toAddress.tr(),
                descTextStyle: TextStyle(fontSize: AppFonts.t16),child: Image.asset(AppImages.addressIcn, scale: 3),),
              Container(
                  padding: EdgeInsetsDirectional.only(
                      start: width() * 0.02),
                  constraints: BoxConstraints(maxWidth: width() * 0.77),
                  child: Text(CacheHelper.getData(key: AppCached.location) ?? "", style: Theme.of(context).textTheme.displaySmall)),
              const Spacer(),
              GestureDetector(
                  onTap: (){
                    navigateTo(widget: const QiblaScreen());
                  },
                  child: Showcase(key: cubit.two,
                      description: LocaleKeys.toQibla.tr(),
                      descTextStyle: TextStyle(fontSize: AppFonts.t16),
                      child: Image.asset(AppImages.qiblaDirection, scale: 3,)))
            ],
          ),
          SizedBox(height: height() * 0.02,),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppRadius.r11)
            ),
            padding: EdgeInsets.symmetric(horizontal: width() * 0.04,
                vertical: height() * 0.02),
            child: Row(
              children: [
                Image.asset(AppImages.prayerIcn, scale: 3,),
                SizedBox(width: width() * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(cubit.currentIndex==1?context.locale.languageCode != "ar" ?'Still on   ':'باقي علي ':
                            context.locale.languageCode != "ar" ?'Next prayer is   ':'باقي على صلاة  ',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width()*0.002),
                          child: Text(cubit.prayerTime[cubit.currentIndex]["name"], style: const TextStyle(color: AppColors.greenColor)),
                        ),
                        CountDownTime(hour: cubit.hours!, minute: cubit.minutes!, second: cubit.seconds!)
                      ],
                    ),
                    Text("${JHijri(fDate: cubit.date, fDisplay: DisplayFormat.DDDMMMYYYY)}", style: TextStyle(
                        fontSize: AppFonts.t12, color: AppColors.grayColor2),)
                  ],
                ),
                const Spacer(),
                Image.asset(cubit.prayerTime[cubit.currentIndex]["icon"])
              ],
            ),
          )
        ],
      );
    });
  }
}
