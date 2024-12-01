import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_btn.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/quraan/controller/quraan_cubit.dart';

class QuraanSections extends StatelessWidget {
  const QuraanSections({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<QuraanCubit,QuraanStates>(
      builder: (context,state) {
        final cubit = BlocProvider.of<QuraanCubit>(context);
        return Row(
          children: [
            Expanded(child: CustomBtn(title: LocaleKeys.surahz.tr(), onTap: (){cubit.changeCurrentBtn(btn: 0);},type:cubit.currentBtn==0? BtnType.selected : BtnType.unSelected)),
            SizedBox(width: width()*0.02),
            Expanded(child: CustomBtn(title: LocaleKeys.quarters.tr(), onTap: (){cubit.changeCurrentBtn(btn: 1);},type: cubit.currentBtn==1? BtnType.selected : BtnType.unSelected)),
            SizedBox(width: width()*0.02),
            Expanded(child: CustomBtn(title: LocaleKeys.parts.tr(), onTap: (){cubit.changeCurrentBtn(btn: 2);},type: cubit.currentBtn==2? BtnType.selected : BtnType.unSelected)),
          ],
        );
      }
    );
  }
}
