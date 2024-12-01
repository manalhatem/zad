import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/widgets/custom_loading.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/sabha_cubit.dart';
import '../../controller/sabhq_state.dart';

class AddZekr extends StatelessWidget {
  final BuildContext ctx;
  final dynamic Function()? onTap;
  const AddZekr({super.key, required this.ctx, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SabhaCubit, SabhaState>(
        builder: (context, state) {
      final cubit = SabhaCubit.get(context);
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:width()*0.07,vertical:width()*0.06),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: width()*0.06),
                Text(onTap== null ?LocaleKeys.addNewZekr.tr():LocaleKeys.editRemembrance.tr(),style: TextStyle(color: AppColors.greenColor,
                    fontSize:AppFonts.t14 ),),
                InkWell(
                  onTap: (){navigatorPop();},
                  child: Text(LocaleKeys.cancelVal.tr(),style: TextStyle(color: AppColors.grayColor3,
                      fontSize:AppFonts.t12),),
                ),
              ],
            ),
            SizedBox(height: width()*0.04),
            Row(
              children: [
                Expanded(child:
                CustomTextField(controller: cubit.newZekrCtr,hintText: LocaleKeys.writeZekr.tr(),type: TextInputType.text)
                ),
                SizedBox(width: width()*0.015),
                state is SabhaStateSubmitState ? const CustomLoading():
                CustomBtn(title:onTap== null ?LocaleKeys.addNewZekr.tr():LocaleKeys.editRemembrance.tr(), onTap:onTap ?? (){
                  cubit.addZekr(context);
                  },type:BtnType.selected)
              ],
            ),
            SizedBox(height: width()*0.01),
          ],
        ),
      ),
    );});
  }
}
