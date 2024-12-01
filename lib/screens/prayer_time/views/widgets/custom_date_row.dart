import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jhijri/jHijri.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../controller/prayer_time_cubit.dart';

class CustomDataRow extends StatelessWidget {
  const CustomDataRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimeCubit, BaseStates>(
        builder: (context, state) {
      final cubit = PrayerTimeCubit.get(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: width() * 0.02),
            child: Text("${JHijri(fDate: cubit.date,
                fDisplay: DisplayFormat.DDDMMMYYYY)} ${DateFormat(
                ', d MMM yyyy', context.locale.languageCode).format(cubit.date)}",
                style: TextStyle(
                    color: AppColors.greenColor, fontSize: AppFonts.t12)),
          ),
          InkWell(
            onTap: () {
              showDatePicker(
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme:
                      CacheHelper.getData(key: AppCached.theme) ==
                          AppCached.darkTheme ?
                      const ColorScheme.dark(
                        primary: AppColors.greenColor,
                        onPrimary: AppColors.whiteCol,
                        onSurface: AppColors.whiteCol,
                      ) :
                      const ColorScheme.light(
                        primary: AppColors.greenColor,
                        onPrimary: AppColors.whiteCol,
                        onSurface: AppColors.blackColor,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.greenColor,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.parse("2000-01-01"),
                lastDate: DateTime.parse("2100-01-01"),
              ).then((value){
                cubit.date=value!;
                cubit.fetchPrayerTime(context: context);
              }
              );
            },
            child: RotatedBox(quarterTurns: 2,
                child: SvgPicture.asset(
                    AppImages.calendre, width: width() * 0.09)),
          ),
        ],
      );
    });}
  }

