import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/widgets/custom_btn.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_border_dropdown.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/suggestions_cubit.dart';

class SuggestionBody extends StatelessWidget {
  const SuggestionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => SuggestionCubit(),
        child: BlocBuilder<SuggestionCubit, BaseStates>(
        builder: (context, state) {
         final cubit = SuggestionCubit.get(context);
         return Scaffold(
          body: CustomPadding(
          withPattern: true,
          widget:Column(
          children: [
           CustomAppBar(text: LocaleKeys.suggestions.tr()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height()*0.03),
                    DropDownBorderItem(
                        items: List.generate(
                            cubit.suggests.length,
                                (index) => DropdownMenuItem<String>(
                                value: cubit.suggests[index]["id"],
                                child: Text(cubit.suggests[index]["name"],
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),))),
                        onChanged: (value) {
                          cubit.changeSuggests(value);
                        },
                        dropDownValue: cubit.changeSuggest,
                        hint: LocaleKeys.suggest.tr()),
                    CustomTextField(controller: cubit.nameController,hintText: LocaleKeys.fullName.tr(),
                    type: TextInputType.text,),
                    CustomTextField(controller: cubit.emailController,hintText: LocaleKeys.email.tr(),type: TextInputType.emailAddress,),
                    CustomTextField(controller: cubit.topicController,hintText: LocaleKeys.topic.tr(),maxLines: 5,type: TextInputType.text,),
                    SizedBox(height: height()*0.3),
                    state is BaseStatesLoadingState ?const Center(child: CustomLoading()):
                    Row(
                      children: [
                        Expanded(child: CustomBtn(title: LocaleKeys.send.tr(), onTap: (){
                          cubit.sendSuggest();
                        }, type: BtnType.selected)),
                      ],
                    )
                  ],
                ),
              ),
            )

          ])));}));
  }
}
