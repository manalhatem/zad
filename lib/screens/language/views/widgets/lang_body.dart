import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/language_cubit.dart';
import 'change_lang_item.dart';

class LanguageBody extends StatelessWidget {
  const LanguageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => LanguageCubit(),
        child: BlocBuilder<LanguageCubit, BaseStates>(
            builder: (context, state) {
              final cubit = LanguageCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      CustomAppBar(text: LocaleKeys.language.tr()),
                      Container(
                        padding: EdgeInsetsDirectional.only(bottom: width()*0.02,top: width()*0.015),
                        margin: EdgeInsetsDirectional.symmetric(vertical: width()*0.08),
                        decoration: BoxDecoration(
                            border: Border.all(color:Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(AppRadius.r8)
                        ),
                        child:
                        Column(
                          children: [
                            ChangeLanguageItem(text: "اللغة العربية",
                              isArabic: context.locale.languageCode=="ar" ? true:false,
                              onTap:(){
                              cubit.changeLanguage(context, true);
                            } ,),
                            Divider(color: Theme.of(context).dividerColor),
                            ChangeLanguageItem(text: "English",
                              isArabic: context.locale.languageCode=="en" ?true:false,
                              onTap:(){
                                cubit.changeLanguage(context, false);
                              } ,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );

            }));
  }
}
