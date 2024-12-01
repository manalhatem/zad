import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/utils/styles.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_btm_sheet.dart';
import '../../../../core/widgets/custom_padding.dart';

class FirstLayer extends StatelessWidget {
  final int surahId;
  const FirstLayer({super.key, required this.surahId});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoraDetailsCubit, SoraDetailsStates>(
        builder: (context, state) {
          final cubit = BlocProvider.of<SoraDetailsCubit>(context);
          return SingleChildScrollView(
            controller: cubit.scrolCtrl,
            padding: EdgeInsets.symmetric(horizontal: width()*0.02),
            child: CustomPadding(
              widget: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(width() * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${LocaleKeys.part.tr()} ${cubit.surahDetailsModel!.data!.ayahs![0].juz.toString()}",
                          style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t16),),
                        Text(cubit.surahDetailsModel!.data!.name.toString(),style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t16,fontFamily: "Amiri"),)
                      ],),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: height() * 0.03),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImages.esmElsoraImg),
                            fit: BoxFit.fill)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(cubit.surahDetailsModel!.data!.name.toString(),
                        style: TextStyle(
                          color: AppColors.greenColor,
                          fontSize: AppFonts.t14,
                          fontFamily: "Amiri",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onTap: (){
                          cubit.changeVisability();
                        },
                        child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                style: Styles.quraanDetailsStyle.copyWith(color: Theme.of(context).primaryColorLight),
                                children: List.generate(cubit.surahDetailsModel!.data!.ayahs!.length, (index) =>
                                    TextSpan(text:"${cubit.surahDetailsModel!.data!.ayahs![index].text.toString()} (${cubit.surahDetailsModel!.data!.ayahs![index].numberInSurah.toString()}) ",
                                        style:
                                        cubit.continueReadingId == cubit.surahDetailsModel!.data!.ayahs![index].numberInSurah! ? Styles.quraanDetailsStyle.copyWith(color: AppColors.greenColor,fontSize: AppFonts.t18):
                                        cubit.currentAya == index? Styles.quraanDetailsStyle.copyWith(color: AppColors.orangeCol,fontSize: AppFonts.t18):
                                        Styles.quraanDetailsStyle.copyWith(color: Theme.of(context).primaryColorLight,fontSize: AppFonts.t18),
                                        recognizer: LongPressGestureRecognizer()..onLongPress = () {
                                          cubit.changeCurrentAya(idx: index , ayahId: cubit.surahDetailsModel!.data!.ayahs![index].numberInSurah!,surahId: surahId);
                                          showModalBottomSheet(
                                            useSafeArea: true,
                                            context: context,
                                            enableDrag: true,
                                            builder: (_) => BlocProvider.value(
                                              value: context.read<SoraDetailsCubit>(),
                                              child: CustomBtmSheet(
                                                scrollPos: cubit.scrolCtrl.position.pixels,
                                                ayah: "${cubit.surahDetailsModel!.data!.ayahs![index].text.toString()} (${cubit.surahDetailsModel!.data!.ayahs![index].numberInSurah.toString()})",
                                                suraName: cubit.surahDetailsModel!.data!.name.toString(),
                                                ayaId: cubit.surahDetailsModel!.data!.ayahs![index].number!,
                                                pageId: cubit.surahDetailsModel!.data!.ayahs![index].page!,
                                                suraId: surahId,
                                                ayaNum: cubit.surahDetailsModel!.data!.ayahs![index].numberInSurah!,
                                              ),
                                            ),).whenComplete(() {
                                            cubit.stopAyah();
                                          });
                                        }),

                                ))),
                      ),
                      Showcase(key: cubit.one, description: LocaleKeys.longPressInSurahDetails.tr(),
                          descTextStyle: TextStyle(fontSize: AppFonts.t14),child:const Text("")),
                      Showcase(key: cubit.two, description: LocaleKeys.pressToListenSurah.tr(),
                          descTextStyle: TextStyle(fontSize: AppFonts.t14),child:const Text(""))
                    ],
                  ),
                  SizedBox(height: height()*0.05,)
                ],
              ),
            ),
          );
        });
  }
}