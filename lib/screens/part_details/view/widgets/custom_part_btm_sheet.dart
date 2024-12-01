import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/part_details/controller/part_details_cubit.dart';
import 'package:zad/screens/part_details/view/widgets/custom_part_drp_down.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart'as sora;
import 'package:zad/screens/sora_details/view/widgets/btm_sheet_header.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_container.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_sora_btn.dart';

class CustomPartBtmSheet extends StatelessWidget {
  final String ayah , suraName ;
  final int ayaNum , ayaId, suraId,id,pageId;
  final bool isPart;
  final double scrollPos;
  const CustomPartBtmSheet({super.key, required this.ayaId, required this.ayaNum, required this.suraId, required this.pageId, required this.scrollPos,
    required this.id,required this.ayah, required this.suraName, required this.isPart});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartDetailsCubit, PartDetailsStates>(
        builder: (context, state) {
          return CustomContainer(
              body: SingleChildScrollView(
                child:
                state is ChangeAyahLoadingState?
                const CustomLoading(fullScreen: true,):
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BtmSheetHeader(
                      title: "$suraName ${LocaleKeys.ayah.tr()} $ayaNum",
                    ),
                    CustomPartBottomSheetDropDowns(
                        suraName: suraName,
                        ayahId: ayaNum,
                        suraId: suraId,
                        pageId: pageId,
                        scrollPos:scrollPos ,
                        hizbId: isPart ? null: id,
                        partId: isPart ? id : null),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height() * 0.02),
                      child: Text(
                        LocaleKeys.explanation.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(width() * 0.02),
                      margin: EdgeInsets.only(bottom: height() * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.r11),
                        border: Border.all(color: AppColors.greenColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ayah,
                            style: TextStyle(
                                fontFamily: "Amiri",
                                fontSize: AppFonts.t14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorLight),
                          ),
                          BlocProvider.of<sora.SoraDetailsCubit>(context).tafsyrResponse==null?const SizedBox():
                          Padding(
                            padding: EdgeInsets.only(
                                top: height() * 0.02,
                                bottom: height() * 0.01),
                            child: Text(
                              BlocProvider.of<sora.SoraDetailsCubit>(context).tafsyrResponse!.data["text"],style: TextStyle(
                                fontSize: AppFonts.t12, color: AppColors.grayColor2),
                            ),
                          ),
                          Text(
                            LocaleKeys.easyExplanation.tr(),
                            style: TextStyle(
                                fontSize: AppFonts.t12, color: AppColors.orangeCol),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomSoraBtn(
                                title: Text(
                                  LocaleKeys.shareVal.tr(),
                                  style: TextStyle(
                                      color: AppColors.greenColor,
                                      fontSize: AppFonts.t12),
                                ),
                                onTap: () {
                                  Share.share(ayah);
                                },
                                type: SoraBtnType.green)),
                        SizedBox(
                          width: width() * 0.03,
                        ),
                        Expanded(
                            child: CustomSoraBtn(
                                title: Text(
                                  LocaleKeys.copyVal.tr(),
                                  style: TextStyle(
                                      color: AppColors.orangeCol,
                                      fontSize: AppFonts.t12),
                                ),
                                onTap: ()async {
                                  await Clipboard.setData(ClipboardData(text: ayah.toString()));
                                  showToast(text: LocaleKeys.textCopied.tr(), state: ToastStates.success);
                                },
                                type: SoraBtnType.orange)),
                      ],
                    )
                  ],
                ),
              ));
        });
  }
}
