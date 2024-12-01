import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/home/model/continue_reading_model.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_drop_down.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_sora_btn.dart';
import '../../../alward_alsarie/controller/alward_alsarie_cubit.dart';

class BottomSheetDropDowns extends StatelessWidget {
  final int suraId , ayahId,pageId;
  final String suraName;
  final double scrollPos;

  const BottomSheetDropDowns({super.key, required this.suraId, required this.ayahId ,required this.pageId, required this.suraName, required this.scrollPos});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoraDetailsCubit, SoraDetailsStates>(
        builder: (context, state) {
          final cubit = BlocProvider.of<SoraDetailsCubit>(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height() * 0.02),
                  child: Text(
                    LocaleKeys.saveTo.tr(),
                    style: TextStyle(fontSize: AppFonts.t14),
                  ),
                ),
                CustomSavedDropDown(
                isMultiLine: false,
                hint: Text(
                  LocaleKeys.choseVal.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                dropVal: cubit.dropDownVal,
                onChanged: (v) {
                  cubit.changeDropVal(v: v,continueReadingModel:ContinueReadingModel(id: suraId, scrollPosition: scrollPos, suraName: suraName, ayaNum: ayahId, isSura: true,pageNum: pageId));
                  // cubit.saveReading(continueReadingModel:ContinueReadingModel(id: suraId, scrollPosition: scrollPos, suraName: suraName, ayaNum: ayahId, isSura: true,pageNum: pageId) );
                },
                items: List.generate(
                  cubit.savedList.length,
                      (index) => DropdownMenuItem(
                    value: (index+1).toString(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(cubit.savedList[index]["img"]),
                        SizedBox(
                          width: width() * 0.02,
                        ),
                        Text(
                          cubit.savedList[index]["name"],
                          style: TextStyle(
                              fontSize: AppFonts.t14,
                              color: AppColors.greenColor),
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       cubit.savedList[index].colorSeparator.toString(),
                        //       style: TextStyle(
                        //           fontSize: AppFonts.t14,
                        //           color: AppColors.greenColor),
                        //     ),
                        //     Text(
                        //       cubit.savedList[index].suraName!=null?
                        //     "${cubit.savedList[index].updatedAt.toString()} ${cubit.savedList[index].suraName.toString()} ${LocaleKeys.ayah.tr()} ${cubit.savedList[index].ayaId.toString()}":
                        //      "",
                        //         style: TextStyle(
                        //             fontSize: AppFonts.t14,
                        //             color: AppColors.grayColor2,fontFamily: "Amiri",)),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height() * 0.02),
                  child: Text(
                    LocaleKeys.audiorecitation.tr(),
                    style: TextStyle(fontSize: AppFonts.t14),
                  ),
                ),
                Row(
              children: [
                Expanded(
                    child: SizedBox(
                      height: height()*0.074,
                      child: CustomSoraBtn(
                          title: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: width() * 0.03),
                                child: SvgPicture.asset(AppImages.estmaaleAya),
                              ),
                              Text(
                                context.locale.languageCode=="ar"? "الاستماع للآية" :"Listen to ayah",
                                style: TextStyle(
                                    fontSize: AppFonts.t14,
                                    color: AppColors.greenColor),
                              ),
                            ],
                          ),
                          onTap: (){
                            BlocProvider.of<AlwardAlsarieCubit>(context).playLists.forEach((element)async {await element!.stop();});
                            cubit.player.stop();
                            cubit.ayahPlayer.play();},
                          type: SoraBtnType.green),
                    )),
              ],
            ),
          ],
        );
      }
    );
  }
}
