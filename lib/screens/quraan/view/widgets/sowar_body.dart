import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/quraan/controller/quraan_cubit.dart';
import 'package:zad/screens/quraan/view/widgets/quraan_item.dart';
import 'package:zad/screens/sora_details/view/sora_details_screen.dart';

class SowarBody extends StatelessWidget {
  const SowarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuraanCubit,QuraanStates>(
        builder: (context,state) {
          final cubit = BlocProvider.of<QuraanCubit>(context);
          return Expanded(
             child: ListView.separated(
              shrinkWrap: true,
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>QuraanItem(
                  type: QuraanItemType.sowar,
                  onTap:  ()async{
                    await cubit.checkConnectivity();
                navigateTo( widget:  SoraDetailsScreen(id: cubit.surahModel!.data![index].number!,continueReading: false, scrollPos: 0.0,connectivityResult: cubit.connectivityResult!,));
              },
                  img: cubit.surahModel!.data![index].revelationType.toString()=="Meccan"? AppImages.makeya:AppImages.madanya,
                  title: cubit.surahModel!.data![index].name.toString(),
                  num: cubit.surahModel!.data![index].number.toString(),
                  desc: "${cubit.surahModel!.data![index].numberOfAyahs.toString()}${LocaleKeys.ayah.tr()} ,"
                      " ${cubit.surahModel!.data![index].revelationType.toString()=="Meccan"?LocaleKeys.macceyah.tr():LocaleKeys.medinan.tr()}"),
              separatorBuilder:(context, index) =>  SizedBox(height: height()*0.02,),
              itemCount: 110),
        );
      }
    );
  }
}
