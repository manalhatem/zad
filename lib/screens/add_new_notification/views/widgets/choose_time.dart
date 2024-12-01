import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/generated/locale_keys.g.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/size.dart';
import '../../controller/add_notification_cubit.dart';

class ChooseTime extends StatelessWidget {
  const ChooseTime({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AddNotificationCubit, BaseStates>(
        builder: (context, state) {
          final cubit = AddNotificationCubit.get(context);
        return InkWell(
          onTap: () => showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (context, child) {
              return Theme(
                  data:  Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.greenColor,
                      onPrimary: Colors.white,
                      onSurface:  AppColors.greenColor,
                      secondary: AppColors.greenColor
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.greenColor,
                      ),
                    ),
                  ),
                  child: child!);
            },
          ).then((value) => cubit.selectTime("${value!.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}")),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height()*0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cubit.time==null?LocaleKeys.notifyTime.tr() : cubit.time!,style: TextStyle(fontSize: AppFonts.t14,color: AppColors.grayColor),),
                const Icon(Icons.access_time,color: AppColors.greenColor,)
              ],
            ),
          ),
        );
      }
    );
  }
}
