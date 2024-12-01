import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/mode_cubit.dart';
import 'change_mode_item.dart';

class ModeBody extends StatelessWidget {
  const ModeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => ModeCubit(),
        child: BlocBuilder<ModeCubit, BaseStates>(
            builder: (context, state) {
              final cubit = ModeCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      CustomAppBar(text: LocaleKeys.mode.tr()),
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
                            ChangeModeItem(text: LocaleKeys.lightMode.tr(),
                              light: CacheHelper.getData(key: AppCached.theme)==AppCached.lightTheme ?true:false,
                              onTap:(){
                              cubit.changeTheme(context: context, isLight: true);
                            } ,),
                            Divider(color: Theme.of(context).dividerColor),
                            ChangeModeItem(text: LocaleKeys.darkMode.tr(),
                              light:  CacheHelper.getData(key: AppCached.theme)==AppCached.darkTheme ?true:false,
                              onTap:(){
                                cubit.changeTheme(context: context, isLight: false);
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
