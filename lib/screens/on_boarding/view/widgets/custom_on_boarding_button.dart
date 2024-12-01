import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/utils/base_state.dart';
import 'package:zad/screens/on_boarding/controller/on_boarding_cubit.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomOnBoardingButton extends StatelessWidget {
  const CustomOnBoardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, BaseStates>(
        builder: (context, state) {
      OnBoardingCubit cubit = OnBoardingCubit.get(context);
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width() * 0.08, vertical: width() * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  if(cubit.index == cubit.onBoardingModel!.data!.length - 1){
                   cubit.login();
                  }else{
                    cubit.pageViewController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                },
                child: SvgPicture.asset(
                    cubit.index ==  cubit.onBoardingModel!.data!.length - 1 ? AppImages.start :
                    AppImages.arrow, width: width() * 0.12)),
            GestureDetector(
                onTap: () {
                  cubit.login();
                },
                child: Text(LocaleKeys.skip.tr(),
                  style: const TextStyle(color: AppColors.orangeCol),))
          ],
        ),
      );
    });
  }
}
