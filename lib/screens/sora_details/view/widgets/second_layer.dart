import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_app_bar.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_container.dart';
import 'package:zad/screens/sora_details/view/widgets/search_btm_sheet.dart';

class SecondLayer extends StatelessWidget {
  final int surahId;

  const SecondLayer({super.key, required this.surahId});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoraDetailsCubit, SoraDetailsStates>(
        builder: (context, state) {
      final cubit = BlocProvider.of<SoraDetailsCubit>(context);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppBar(
            text: LocaleKeys.qauraan.tr(),
            clr: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal:width()*0.03,vertical:width()*0.045),
          ),
          CustomContainer(
              body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.listenTo.tr(),
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
                      Expanded(child: Text(cubit.surahDetailsModel!.data!.name.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t16,fontFamily: "Amiri"))),
                      SizedBox(width: width()*0.02,),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            useSafeArea: true,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (_) => BlocProvider.value(
                              value: context.read<SoraDetailsCubit>(),
                              child:  SearchBtmSheet(surahId: surahId,),
                            ),);},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: width()*0.4),
                              child: Text(
                                cubit.shyokhModel!.data!.isNotEmpty?
                                cubit.shyokhModel!.data![cubit.currentsheykh].name.toString() : LocaleKeys.noResults.tr(),
                                overflow: TextOverflow.visible,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t12),
                              ),
                            ),
                            SvgPicture.asset(AppImages.dropDownIcn),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Slider(
                  value: cubit.position,
                  onChanged: (v) {cubit.changePosition(v);},
                  max: cubit.max,
                  min: 0,
                  activeColor: AppColors.orangeCol,

                ),
                if(cubit.shyokhModel!.data!.isNotEmpty)
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
                      cubit.player.playing?await cubit.stop():await cubit.play(suraName: cubit.surahDetailsModel!.data!.name.toString(),
                        suraNum: cubit.surahDetailsModel!.data!.number.toString(),fromDetails: true);
                    },
                    child: Image.asset(!cubit.player.playing?AppImages.playIcn : AppImages.pause, scale: 3),
                  ),
                ],
              )
            ],
          ))
        ],
      );
    });
  }
}
