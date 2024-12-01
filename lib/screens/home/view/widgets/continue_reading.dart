import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zad/core/local/boxes.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_btn.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/home/model/continue_reading_model.dart';
import 'package:zad/screens/part_details/view/part_details_screen.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/sora_details/view/sora_details_screen.dart';
import '../../../../core/widgets/cant_change_lang_dialog.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SoraDetailsCubit,SoraDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var box =Hive.box<ContinueReadingModel>(AppBox.continueReadingBox);
        return
          box.isEmpty? const SizedBox.shrink():
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.followReadingbg),fit: BoxFit.fill)
            ),
            padding: EdgeInsets.symmetric(
                horizontal: width()*0.03,
                vertical: height()*0.02
            ),
            child: Row(
              children: [
                Image.asset(AppImages.quraanWhiteImg,scale: 3,),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: width()*0.02,end: width()*0.03),
                    child: Column(
                      children: [
                        Text(LocaleKeys.continueReading.tr(),style: TextStyle(color: Colors.white,fontSize: AppFonts.t14),),
                        RichText(
                          text:  TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: AppFonts.t14,fontFamily: "Amiri"),
                            children:  <TextSpan>[
                              TextSpan(text: LocaleKeys.stopped.tr()),
                              TextSpan(text: box.values.first.suraName.toString(), style: const TextStyle(color: AppColors.orangeCol,fontWeight: FontWeight.bold)),
                              TextSpan(text: " ${LocaleKeys.page_.tr()}"),
                              TextSpan(text:
                              box.values.first.pageNum.toString(), style: const TextStyle(color: AppColors.orangeCol,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                CustomBtn(
                  title: LocaleKeys.continue_.tr(),
                  onTap:(){
                    context.locale.languageCode=="en"?
                    showDialog(
                      context: context,
                      builder: (context) => const CantChangeLangDialog(),
                    ):
                    box.values.first.isSura==true?
                  navigateTo(widget: SoraDetailsScreen(
                    connectivityResult: BlocProvider.of<SoraDetailsCubit>(context).connectivityResult!,
                    scrollPos: box.values.first.scrollPosition,
                      id: box.values.first.id,
                      continueReadingId: box.values.first.ayaNum,continueReading: true)):
                       navigateTo(widget: PartDetailsScreen(isPart:box.values.first.isPart!,id: box.values.first.id,continueReading: true, continueReadingId: box.values.first.ayaNum,scrollPos: box.values.first.scrollPosition,));
                  },
                  type: BtnType.normal,)
              ],
            ),
          );
      }
    );
  }
}
