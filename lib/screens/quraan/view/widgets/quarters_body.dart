import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/part_details/view/part_details_screen.dart';
import 'package:zad/screens/quraan/controller/quraan_cubit.dart';
import 'package:zad/screens/quraan/view/widgets/quraan_item.dart';

class QuartersBody extends StatelessWidget {
  const QuartersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuraanCubit,QuraanStates>(
        builder: (context,state) {
          final cubit = BlocProvider.of<QuraanCubit>(context);
        return Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => QuraanItem(
                type: QuraanItemType.quarters,
                num: cubit.hizbModel!.data![index].number.toString(),
                onTap: () {
                  navigateTo( widget: PartDetailsScreen(id: cubit.hizbModel!.data![index].number!,isPart: false,continueReading: false,scrollPos: 0,));
                },
                title: cubit.hizbModel!.data![index].ayah.toString(),
                desc: "${cubit.hizbModel!.data![index].surah.toString()}  ${LocaleKeys.ayah.tr()} ${cubit.hizbModel!.data![index].numberInSurah.toString()}",
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: height() * 0.02,
              ),
              itemCount: cubit.hizbModel!.data!.length),
        );
      }
    );
  }
}
