import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_row.dart';
import 'package:zad/main.dart';
import 'package:zad/screens/mode/views/mode_view.dart';
import 'package:zad/screens/notification/views/notification_view.dart';
import 'package:zad/screens/settings/view/widgets/contact_us.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/dark_image.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../about_app/views/about_app_view.dart';
import '../../../about_contributors/views/about_contributors_view.dart';
import '../../../language/views/language_view.dart';
import '../../../suggetions/views/suggetions_view.dart';
import '../../controller/setting_cubit.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => SettingCubit()..fetchScreen(),
        child: BlocBuilder<SettingCubit, BaseStates>(
            builder: (context, state) {
              final cubit = SettingCubit.get(context);
              return Scaffold(
                  body: CustomPadding(
                      withPattern: true,
                      widget:Column(
                          children: [
                            CustomAppBar(text: LocaleKeys.settings_.tr(),withBack: false),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.notification
                                        : AppImages.notification
                                      , text: LocaleKeys.notification.tr(),
                                      onTap: (){
                                        navigateTo( widget: const NotificationScreen());
                                      }, networkImg: false,
                                    ),
                                    Divider(color: Theme.of(context).dividerColor),
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme ? DarkAppImages.lang : AppImages.lang,
                                      text: LocaleKeys.language.tr(),
                                      onTap: (){
                                        navigateTo( widget: const LanguageScreen());
                                      }, networkImg: false,
                                    ),
                                    Divider(color: Theme.of(context).dividerColor),
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.mode
                                        : AppImages.mode
                                      , text: LocaleKeys.mode.tr(),
                                      onTap: (){
                                        navigateTo( widget: const ModeScreen());
                                      }, networkImg: false,
                                    ),
                                    state is  BaseStatesLoadingState|| CacheHelper.getData(key: AppCached.playStore)==""?const SizedBox.shrink():
                                    Divider(color: Theme.of(context).dividerColor),
                                    state is  BaseStatesLoadingState?const CustomLoading(fullScreen: false,):
                                    CacheHelper.getData(key: AppCached.playStore)==""?const SizedBox.shrink():
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.share
                                        : AppImages.share
                                      , text: LocaleKeys.shareRent.tr(),
                                      onTap: (){
                                        Share.share(Platform.isAndroid?CacheHelper.getData(key: AppCached.playStore).toString():CacheHelper.getData(key: AppCached.appleStore).toString());
                                      }, networkImg: false,
                                    ),
                                    Divider(color: Theme.of(context).dividerColor),
                                    state is  BaseStatesLoadingState?const CustomLoading(fullScreen: false,):
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.contact
                                        : AppImages.contact
                                      , text: LocaleKeys.contactUs.tr(),
                                      onTap: (){
                                        showModalBottomSheet(
                                            context: navigatorKey.currentContext!,
                                            builder: (_) => ContactUs(
                                              website: CacheHelper.getData(key: AppCached.website),
                                              whatsapp: CacheHelper.getData(key: AppCached.whatsapp),
                                            ),
                                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(35))));
                                      }, networkImg: false,
                                    ),
                                    Divider(color: Theme.of(context).dividerColor),
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.suggest
                                        : AppImages.suggest
                                      , text: LocaleKeys.suggestions.tr(),
                                      onTap: (){
                                        navigateTo( widget: const SuggestionScreen());
                                      }, networkImg: false,
                                    ),
                                    state is  BaseStatesLoadingState|| CacheHelper.getData(key: AppCached.playStore)==""?const SizedBox.shrink():
                                    Divider(color: Theme.of(context).dividerColor),
                                    state is  BaseStatesLoadingState?const CustomLoading(fullScreen: false,):
                                    CacheHelper.getData(key: AppCached.playStore)==""?const SizedBox.shrink():
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.rateApp
                                        : AppImages.rateApp
                                      , text: LocaleKeys.rateApp.tr(),
                                      onTap: (){
                                        Platform.isAndroid?
                                        launchUrl(Uri.parse(CacheHelper.getData(key: AppCached.playStore).toString()),mode: LaunchMode.externalApplication):
                                        launchUrl(Uri.parse(CacheHelper.getData(key: AppCached.appleStore).toString()),mode: LaunchMode.externalApplication);
                                      }, networkImg: false,
                                    ),
                                    Divider(color: Theme.of(context).dividerColor),
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.aboutShare
                                        : AppImages.aboutShare
                                      , text: LocaleKeys.aboutShareholders.tr(),
                                      onTap: ()async{
                                        navigateTo( widget: const AboutContributorsScreen());
                                      }, networkImg: false,
                                    ),
                                    Divider(color: Theme.of(context).dividerColor),
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                                        ? DarkAppImages.aboutApp
                                        : AppImages.aboutApp
                                      , text: LocaleKeys.aboutApp.tr(),
                                      onTap: (){
                                        navigateTo( widget: const AboutAppScreen());
                                      }, networkImg: false,
                                    ),
                                    Divider(color: Theme.of(context).dividerColor),
                                    CustomRow(img:
                                    CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme ? DarkAppImages.downloadQuran : AppImages.downloadQuran,
                                      text: LocaleKeys.downloadQuraan.tr(),
                                      onTap:() => cubit.downloadQuraan(), networkImg: false,
                                    ),
                                    if(cubit.showProgress)
                                      LinearProgressIndicator(
                                        color: AppColors.greenColor,
                                        value: cubit.progressVal,
                                      )
                                  ],
                                ),
                              ),
                            )
                          ])));}));
  }
}