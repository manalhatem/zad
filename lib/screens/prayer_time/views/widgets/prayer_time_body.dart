import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/colors.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/prayer_time_cubit.dart';
import 'custom_date_row.dart';
import 'custom_prayer_time.dart';

class PrayerTimeBody extends StatelessWidget {
final int currentIndex;

  const PrayerTimeBody({super.key, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => PrayerTimeCubit()..initFunction(context: context),
        child: BlocBuilder<PrayerTimeCubit, BaseStates>(
            builder: (context, state) {
              final cubit = PrayerTimeCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      InkWell(
                          onTap: (){
                        cubit.determinePosition(context);
                          },
                          child: CustomAppBar(text: LocaleKeys.praytimes.tr())),
                      BlocProvider.value(value: context.read<PrayerTimeCubit>(),
                        child: const CustomDataRow()),
                      state is BaseStatesLoadingState?
                      const CustomLoading(fullScreen: true):
                      Expanded(
                        child:ListView.builder(itemBuilder: (context, index){
                          return  CustomPrayerTime(img:cubit.prayerTime[index]["icon"],
                            name:cubit.prayerTime[index]["name"],
                              time:index==0?cubit.prayerTimeModel!.timings!.fajr.toString():
                              index==1?cubit.prayerTimeModel!.timings!.sunrise.toString():
                              index==2?cubit.prayerTimeModel!.timings!.dhuhr.toString():
                              index==3?cubit.prayerTimeModel!.timings!.asr.toString():
                              index==4?cubit.prayerTimeModel!.timings!.maghrib.toString():
                             cubit.prayerTimeModel!.timings!.isha.toString(),
                            textClr: currentIndex==index? Colors.white:AppColors.blackColor,
                            col: currentIndex==index?
                            AppColors.greenColor:
                            AppColors.greenColor.withOpacity(.05));
                        }, itemCount: cubit.prayerTime.length)
                        ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     MaterialButton(
                      //       color: Colors.red,
                      //       onPressed: () => cubit.fetchQuraan(),
                      //       child: const Text("testttttttttttttttttttttt"),
                      //     ),
                      //     MaterialButton(
                      //       color: Colors.blueAccent,
                      //       onPressed: () => cubit.printttt(),
                      //       child: const Text("print"),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              );
            }));
  }
}
