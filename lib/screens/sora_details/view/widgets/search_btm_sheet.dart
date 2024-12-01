import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_text_field.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/sora_details/view/widgets/btm_sheet_header.dart';
import 'package:zad/screens/sora_details/view/widgets/custom_container.dart';

class SearchBtmSheet extends StatelessWidget {
  final int surahId;

  const SearchBtmSheet({super.key, required this.surahId});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocBuilder<SoraDetailsCubit, SoraDetailsStates>(
          builder: (context, state) {
            final cubit = BlocProvider.of<SoraDetailsCubit>(context);
            return  SizedBox(
              height: height()*0.6,
              child: CustomContainer(
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          BtmSheetHeader(title: LocaleKeys.selTilawa.tr()),
                          SizedBox(height: height()*0.02),
                          CustomTextField(
                            controller: cubit.searchCtrl,
                              type: TextInputType.text,
                            hintText: context.locale.languageCode=="ar"?"بحث" : "Search",
                            onChanged: (p0) => cubit.checkStopTyping(id:surahId),
                          ),
                          Padding(
                          padding: EdgeInsets.symmetric(vertical: height() * 0.02),
                          child: Text(LocaleKeys.sheykh.tr(),
                            style: TextStyle(fontSize: AppFonts.t14),
                          ),
                        ),
                          ListView.separated(
                          shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder:(context, index) =>  InkWell(
                              onTap: (){cubit.changeCurrentSheykh(idx: index, surahId: surahId, sheykhId: cubit.shyokhModel!.data![index].id!);},
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: height()*0.015),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.volumeIcn),
                                    SizedBox(width: width()*0.02,),
                                    Text(cubit.shyokhModel!.data![index].name.toString(), style: TextStyle(color:cubit.currentsheykh==index? AppColors.orangeCol : AppColors.greenColor,fontSize: AppFonts.t14),),
                                    const Spacer(),
                                    if(cubit.currentsheykh==index)
                                    SvgPicture.asset(AppImages.check)
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: cubit.shyokhModel!.data!.length)
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
