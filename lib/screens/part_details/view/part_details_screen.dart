import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/utils/styles.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_padding.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/part_details/controller/part_details_cubit.dart';
import 'package:zad/screens/part_details/view/widgets/custom_part_btm_sheet.dart';

import '../../../core/widgets/custom_error_widget.dart';

class PartDetailsScreen extends StatelessWidget {
  final int id;
  final bool isPart , continueReading;
  final int?continueReadingId;
  final double scrollPos;
  const PartDetailsScreen({super.key, required this.id, required this.isPart, required this.continueReading , required this.scrollPos , this.continueReadingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PartDetailsCubit()..fetchScreen(id: id,isPart: isPart,context: context,continueReading: continueReading,scrollPos:scrollPos),
    child: BlocBuilder<PartDetailsCubit,PartDetailsStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<PartDetailsCubit>(context);
        return Scaffold(
          body: state is PartDetailsLoadingState?
          const CustomLoading(fullScreen: true,):
          state is PartDetailsErrorState?
          Center(
            child: CustomShowMessage(
              title: state.err,
              onPressed: () => cubit.fetchScreen(id: id,isPart: isPart,context: context,continueReading: continueReading,scrollPos: 0),
            ),
          ):
          SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: cubit.scrolCtrl,
                  padding: EdgeInsets.symmetric(horizontal: width()*0.02),
                  child: CustomPadding(
                    widget: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(width() * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${LocaleKeys.part.tr()} ${cubit.partDetailsModel!.data![index].juz.toString()}",
                                    style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14),),
                                  Text(cubit.partDetailsModel!.data![index].name.toString(),style: TextStyle(color: AppColors.greenColor,fontFamily: "Amiri",fontSize: AppFonts.t14),)
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
                                child: Text(cubit.partDetailsModel!.data![index].name.toString(),
                                  style: TextStyle(
                                    color: AppColors.greenColor,
                                    fontSize: AppFonts.t14,
                                    fontFamily: "Amiri",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    style: Styles.quraanDetailsStyle.copyWith(color: Theme.of(context).primaryColorLight),
                                    children: List.generate(cubit.partDetailsModel!.data![index].ayahs!.length, (idx) =>
                                        TextSpan(text:"${cubit.partDetailsModel!.data![index].ayahs![idx].text.toString()} (${cubit.partDetailsModel!.data![index].ayahs![idx].numberInSurah.toString()}) ",
                                            style:
                                            continueReadingId == cubit.partDetailsModel!.data![index].ayahs![idx].numberInSurah? Styles.quraanDetailsStyle.copyWith(color: AppColors.greenColor,fontSize: AppFonts.t18):
                                            cubit.currentAya == cubit.partDetailsModel!.data![index].ayahs![idx].number! ?
                                            Styles.quraanDetailsStyle.copyWith(color: AppColors.orangeCol,fontSize: AppFonts.t18):
                                            Styles.quraanDetailsStyle.copyWith(color: Theme.of(context).primaryColorLight,fontSize: AppFonts.t18),
                                            recognizer: LongPressGestureRecognizer()..onLongPress = () {
                                              BlocProvider.of<PartDetailsCubit>(context).changeCurrentAya(idx: index ,
                                                  currAya: cubit.partDetailsModel!.data![index].ayahs![idx].number!,
                                                  ayahId: cubit.partDetailsModel!.data![index].ayahs![idx].numberInSurah!,context: context,
                                                  surahId: cubit.partDetailsModel!.data![index].ayahs![idx].surah!.number!);
                                              showModalBottomSheet(
                                                  useSafeArea: true,
                                                  context: context,
                                                  enableDrag: true,
                                                  builder: (_) => BlocProvider.value(
                                                    value: context.read<PartDetailsCubit>(),
                                                    child: CustomPartBtmSheet(
                                                      scrollPos: cubit.scrolCtrl.position.pixels,
                                                      isPart: isPart,
                                                      id: id,
                                                      ayah: "${cubit.partDetailsModel!.data![index].ayahs![idx].text.toString()} (${cubit.partDetailsModel!.data![index].ayahs![idx].numberInSurah.toString()})",
                                                      suraName: cubit.partDetailsModel!.data![index].ayahs![idx].surah!.name.toString(),
                                                      ayaId: cubit.partDetailsModel!.data![index].ayahs![idx].number!,
                                                      pageId: cubit.partDetailsModel!.data![index].ayahs![idx].page!,
                                                      suraId: cubit.partDetailsModel!.data![index].ayahs![idx].surah!.number!,
                                                      ayaNum: cubit.partDetailsModel!.data![index].ayahs![idx].numberInSurah!,
                                                    ),
                                                  )).whenComplete(() {
                                                cubit.stopAyah();
                                              });
                                            }),

                                    ))),
                            SizedBox(height: height()*0.05,)
                          ],
                        ),
                        separatorBuilder:(context, index) =>  const SizedBox.shrink(),
                        itemCount: cubit.partDetailsModel!.data!.length)
                  ),
                )
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}
