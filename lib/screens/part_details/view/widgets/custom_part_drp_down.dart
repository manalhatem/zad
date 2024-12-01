import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/home/model/continue_reading_model.dart';
import 'package:zad/screens/part_details/controller/part_details_cubit.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_drop_down.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_sora_btn.dart';
import '../../../../main.dart';
import '../../../alward_alsarie/controller/alward_alsarie_cubit.dart';
import '../../../sora_details/controller/sora_details_cubit.dart';

class CustomPartBottomSheetDropDowns extends StatelessWidget {
  final int suraId , ayahId,pageId;
  final String suraName;
  final int? partId , hizbId ;
  final double scrollPos;
  const CustomPartBottomSheetDropDowns({super.key, required this.suraId, required this.pageId, required this.ayahId, required this.suraName,
    required this.hizbId ,required this.partId ,required this.scrollPos});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartDetailsCubit, PartDetailsStates>(
        builder: (context, state) {
          final cubit = BlocProvider.of<PartDetailsCubit>(context);
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
                    cubit.changeDropVal(v: v,continueReadingModel:ContinueReadingModel(id: partId??hizbId!, scrollPosition: scrollPos, suraName: suraName, ayaNum: ayahId, isSura: false,pageNum: pageId, isPart: partId==null?false:true));
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
                                  LocaleKeys.listenTo.tr(),
                                  style: TextStyle(
                                      fontSize: AppFonts.t14,
                                      color: AppColors.greenColor),
                                ),
                              ],
                            ),
                            onTap: (){
                              BlocProvider.of<SoraDetailsCubit>(navigatorKey.currentContext!).player.stop();
                              BlocProvider.of<AlwardAlsarieCubit>(navigatorKey.currentContext!).playLists.forEach((element)async {await element!.stop();});
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
