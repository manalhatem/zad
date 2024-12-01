import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/utils/azan_cubit.dart';
import 'package:zad/core/utils/my_navigate.dart';

import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../main.dart';
import '../../controller/notification_cubit.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzanCubit, BaseStates>(
        builder: (context, state) {
      final cubit = AzanCubit.get(context);
      return  Padding(
        padding: EdgeInsets.only(top: height() * .024),
        child: Column(
          children: List.generate(
              cubit.notificationModel!.data!.length,
                  (index) =>  Dismissible(
                  movementDuration: const Duration(milliseconds: 800),
                  direction: DismissDirection.startToEnd,
                  resizeDuration: const Duration(seconds: 2),
                  key: UniqueKey(),
                  onDismissed: (details) {
                      showDialog(
                        barrierDismissible: false,
                        context: navigatorKey.currentContext!,
                        builder: (_) => AlertDialog(
                          surfaceTintColor: Colors.white,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          content: SizedBox(
                            height: height()*0.07,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child:
                            MaterialButton(
                            onPressed: () {
                          cubit.deleteNotification(id:cubit.notificationModel!.data![index].id!.toString(), index: index);
                          navigatorPop();
                          },
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r11)),
                              padding: EdgeInsets.symmetric(horizontal: width()*0.02,vertical: height()*0.019),
                              color:AppColors.orangeCol,
                              child: Text(LocaleKeys.yes.tr(),style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppFonts.t12),),
                            )
                                ),
                                SizedBox(width: width()*0.02),
                                Expanded(
                                  child: CustomBtn(
                                    onTap: () {
                                      cubit.getUserNotification(whenDelete: true);
                                      navigatorPop(); }, title: LocaleKeys.no.tr(), type: BtnType.unSelected,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text(LocaleKeys.deleteAlert.tr(),style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center),

                        )

                    );
                  },
                  background: Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.symmetric(vertical: width()*0.02),
                    margin: EdgeInsetsDirectional.only(bottom:width()*0.02),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(AppRadius.r8)),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: width()*0.05),
                      child: Text(LocaleKeys.delete.tr(),style: TextStyle(color: AppColors.whiteCol,fontSize: AppFonts.t16),),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: width()*0.02),
                    margin: EdgeInsetsDirectional.only(bottom:width()*0.02),
                    decoration: BoxDecoration(
                        border: Border.all(color:Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(AppRadius.r8)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: width()*0.035),
                      titleAlignment:ListTileTitleAlignment.top ,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.notificationModel!.data![index].title.toString(), style: Theme.of(context).textTheme.titleMedium),
                          Text("${cubit.notificationModel!.data![index].type}  ${cubit.notificationModel!.data![index].time}", style: TextStyle(fontSize: AppFonts.t10, color: AppColors.greenColor)),
                        ],
                      ),
                      trailing: GestureDetector(
                          onTap: (){cubit.changeStatus(id: cubit.notificationModel!.data![index].id.toString(), isStatic: false, index: index);},
                          child: SvgPicture.asset(cubit.notificationModel!.data![index].isActive == true? AppImages.active:AppImages.notActive)),
                    ),
                  ))),
        ),
      );

        });
  }
}
