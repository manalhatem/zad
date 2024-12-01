import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_app_bar.dart';
import 'package:zad/core/widgets/custom_btn.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_text_field.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/add_alwerd/controller/add_alwerd_cubit.dart';

class EditWerd extends StatelessWidget {
  final int id;

  const EditWerd({super.key,required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAlwardCubit, AddAlwerdStates>(
        builder: (context, state) {
          final cubit = BlocProvider.of<AddAlwardCubit>(context);
          return  IntrinsicHeight(
            child: Column(
              children: [
                CustomAppBar(text: LocaleKeys.editList.tr()),
                SizedBox(height: width()*0.04),
                CustomTextField(controller: cubit.sectionName,hintText: LocaleKeys.nameOfSection.tr(),
                  type: TextInputType.text,
                  style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14),),
                const Spacer(),
                state is AddToPlayListLoadingState?
                const CustomLoading(fullScreen: false,):
                Row(
                  children: [
                    Expanded(child: CustomBtn(title: LocaleKeys.save.tr(),
                        onTap: () => cubit.editListName(id: id), type: BtnType.selected)),
                  ],
                ),
                SizedBox(height: width()*0.02),
              ],
            ),
          );});
  }
}
