import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/alward_alsarie/controller/alward_alsarie_cubit.dart';

import '../../../../core/utils/size.dart';

class PlayerSection extends StatelessWidget {
  const PlayerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlwardAlsarieCubit, AlwerdAlsarieStates>(
        builder: (context, state) {
          final cubit = BlocProvider.of<AlwardAlsarieCubit>(context);
        return Container(
          margin: EdgeInsets.only(top: height()*0.01),
          padding: EdgeInsets.all(width()*0.02),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade200,blurRadius: 3,spreadRadius: 3)
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(LocaleKeys.listenTo.tr(),
                style: TextStyle(
                    fontSize: AppFonts.t12, color: AppColors.greenColor),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: height() * 0.02,
                    bottom: height() * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(
                        cubit.tracksModel!.data![cubit.currentPlayList].tracks![cubit.currentAudio].title.toString(),
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t12,fontFamily: "Amiri"))),
                    SizedBox(width: width()*0.02,),
                  ],
                ),
              ),
              Slider(
                value: cubit.position,
                onChanged: (v) {
                  cubit.changePosition(v);},
                max: cubit.max,
                min: 0,
                activeColor: AppColors.orangeCol,

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => cubit.prevPlay(),
                    child: Transform.flip(
                        flipX:context.locale.languageCode=="ar"?false: true,
                        child: Image.asset(AppImages.prevIcn, scale: 3)),
                  ),
                  SizedBox(
                    width: width() * 0.03,
                  ),
                  InkWell(
                    onTap: () => cubit.playLists[cubit.currentPlayList]!.playing? cubit.pause(): cubit.resume(),
                    child: Image.asset(cubit.playing? AppImages.pause : AppImages.playIcn , scale: 3),
                  ),
                  SizedBox(
                    width: width() * 0.03,
                  ),
                  InkWell(
                    onTap: () => cubit.nextPlay(),
                    child: Transform.flip(
                        flipX: context.locale.languageCode=="ar"?false: true,
                        child: Image.asset(AppImages.nextIcn, scale: 3)),
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}
