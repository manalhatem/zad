// import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/utils/azan_cubit.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/screens/notification/views/widgets/azan_notification.dart';
import 'package:zad/screens/notification/views/widgets/suggest_notification.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import 'add_notification.dart';
import 'my_notification.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => AzanCubit()..fetchDate(),
        child: BlocBuilder<AzanCubit, BaseStates>(
            builder: (context, state) {
              final cubit = AzanCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      GestureDetector(
                          onTap: (){},
                          child: CustomAppBar(text: LocaleKeys.notification.tr())),
                      state is BaseStatesLoadingState ?const CustomLoading(fullScreen: true):
                      state is BaseStatesErrorState ?
                      Expanded(
                        child: Column(
                          children: [
                            const Spacer(),
                            Center(
                              child: CustomShowMessage(
                                title: state.msg,
                                onPressed: () {
                                  cubit.fetchDate();
                                },
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ):
                      Column(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: [
                          cubit.notificationStaticModel==null ?
                          const SizedBox.shrink():
                          Text(LocaleKeys.suggestedAlerts.tr(), style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t16),),
                          cubit.notificationStaticModel==null ?
                          const SizedBox.shrink():
                          const SuggestNotification(),
                          cubit.notificationStaticModel==null ?
                          const SizedBox.shrink():
                          Padding(
                            padding:  EdgeInsets.only(top: width()*0.02, bottom:width()*0.04),
                            child: Text(LocaleKeys.myNotification.tr(), style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t16),),
                          ),
                          if(CacheHelper.getData(key: AppCached.enabledLocation)==true)...[
                          AzanNotificationItem(title: LocaleKeys.enableFajr.tr(), isEnable: cubit.fajerEnable,onTap:(){
                            if(CacheHelper.getData(key: AppCached.autoStart)!=true){
                              // getAutoStartPermission();
                              CacheHelper.saveData(key: AppCached.autoStart,value: true);
                            }else{cubit.switchFajr();}
                          },),
                          AzanNotificationItem(title: LocaleKeys.enableDuher.tr(), isEnable: cubit.duherEnable,onTap:(){
                            if(CacheHelper.getData(key: AppCached.autoStart)!=true){
                            // getAutoStartPermission();
                            CacheHelper.saveData(key: AppCached.autoStart,value: true);
                            }else{cubit.switchDuhr();}}),
                          AzanNotificationItem(title: LocaleKeys.enableAsr.tr(), isEnable: cubit.asrEnable,onTap:(){
                            if(CacheHelper.getData(key: AppCached.autoStart)!=true){
                               // getAutoStartPermission();
                              CacheHelper.saveData(key: AppCached.autoStart,value: true);
                            }else{cubit.switchAsr();}}),
                          AzanNotificationItem(title: LocaleKeys.enableMaghreb.tr(), isEnable: cubit.maghrebEnable,onTap:(){
                            if(CacheHelper.getData(key: AppCached.autoStart)!=true){
                               // getAutoStartPermission();
                              CacheHelper.saveData(key: AppCached.autoStart,value: true);
                            }else{cubit.switchMaghreb();}}),
                          AzanNotificationItem(title: LocaleKeys.enableIsha.tr(), isEnable: cubit.ishaEnable,onTap:(){
                            if(CacheHelper.getData(key: AppCached.autoStart)!=true){
                               // getAutoStartPermission();
                              CacheHelper.saveData(key: AppCached.autoStart,value: true);
                            }else{cubit.switchIsha();}}),
                          ],
                          const AddNewNotify(),
                          cubit.notificationModel==null ?
                          const SizedBox.shrink():
                          const MyNotification()
                        ],
                      )
                    ],
                  ),
                ),
              );

            }));
  }
}