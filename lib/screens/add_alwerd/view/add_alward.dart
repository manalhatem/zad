import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/widgets/custom_app_bar.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/screens/add_alwerd/controller/add_alwerd_cubit.dart';
import 'package:zad/screens/add_alwerd/view/edit_werd.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/size.dart';
import '../../../core/widgets/custom_border_dropdown.dart';
import '../../../core/widgets/custom_btn.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../generated/locale_keys.g.dart';

class AddAlward extends StatelessWidget {
  final int? id;
  final bool isEdit;
  const AddAlward({super.key, this.id,required this.isEdit});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddAlwardCubit(),
        child: BlocBuilder<AddAlwardCubit, AddAlwerdStates>(
            builder: (context, state) {
          final cubit = BlocProvider.of<AddAlwardCubit>(context);
          return  LayoutBuilder(
            builder: (context,constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal:width()*0.04),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child:
                    isEdit?EditWerd(id: id!,):
                    IntrinsicHeight(
                      child: Column(
                        children: [
                          CustomAppBar(text:id==null? LocaleKeys.addList.tr() : LocaleKeys.edit.tr()),
                          SizedBox(height: width()*0.04),
                          if(id==null)
                          CustomTextField(controller: cubit.sectionName,hintText: LocaleKeys.nameOfSection.tr(),
                          type: TextInputType.text,
                          style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14),),
                          DropDownBorderItem(
                              items: List.generate(
                                  cubit.type.length,
                                      (index) => DropdownMenuItem<String>(
                                      value: cubit.type[index]["id"],
                                      child: Text(cubit.type[index]["name"],
                                        style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14)))),
                              onChanged: (value) {
                                cubit.changeType(value);
                              },
                              dropDownValue: cubit.chooseType,
                              hint: LocaleKeys.chooseType.tr(),
                            ),
                          SizedBox(height: width()*0.02),
                          if(cubit.azkarListenModel!=null)
                          DropDownBorderItem(
                              items: List.generate(
                                  cubit.azkarListenModel!.data!.length,
                                      (index) => DropdownMenuItem<String>(
                                      value: cubit.azkarListenModel!.data![index].iD.toString(),
                                      child: Text(cubit.azkarListenModel!.data![index].tITLE.toString(),
                                        style:TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14)))),
                              onChanged: (value) {
                                cubit.changeSuraZikr(value);
                              },
                              dropDownValue: cubit.currentSuraZikr,
                              hint: context.locale.languageCode=="ar"? "اختر الذكر" : "Chose zekr"),
                          SizedBox(height: width()*0.02),
                          if(cubit.surahModel!=null)
                          DropDownBorderItem(
                              items: List.generate(
                                  cubit.surahModel!.data!.length,
                                      (index) => DropdownMenuItem<String>(
                                      value: "${cubit.surahModel!.data![index].number.toString()} //${cubit.surahModel!.data![index].name.toString()}",
                                      child: Text(cubit.surahModel!.data![index].name.toString(),
                                        style:TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14,fontFamily: "Amiri")))),
                              onChanged: (value) {
                                cubit.changeSura(value: value!);
                              },
                              dropDownValue: cubit.currentSuraZikr,
                              hint: LocaleKeys.chooseSurah.tr()),
                          SizedBox(height: width()*0.02),
                          if(cubit.shyokhModel!=null)
                          DropDownBorderItem(
                              items: List.generate(
                                  cubit.shyokhModel!.data!.length,
                                      (index) => DropdownMenuItem<String>(
                                      value: cubit.shyokhModel!.data![index].reciterId.toString(),
                                      child: Text(cubit.shyokhModel!.data![index].name.toString(),
                                        style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14)))),
                              onChanged: (value) {
                                cubit.changeCurrentSheykh(value);
                              },
                              dropDownValue: cubit.currentSheykh,
                              hint: LocaleKeys.sheikhVoice.tr()),
                          const Spacer(),
                          state is AddToPlayListLoadingState?
                          const CustomLoading(fullScreen: false,):
                          Row(
                            children: [
                              Expanded(child: CustomBtn(title: LocaleKeys.save.tr(), onTap: () => cubit.addToPlayList(id: id), type: BtnType.selected)),
                            ],
                          ),
                          SizedBox(height: width()*0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          );}),
      ),
    );



  }
}
