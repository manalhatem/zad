import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/widgets/custom_btn.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_border_dropdown.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/add_notification_cubit.dart';
import 'choose_time.dart';
class AddNotificationBody extends StatelessWidget {
  const AddNotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => AddNotificationCubit()..getNotificationType(),
        child: BlocBuilder<AddNotificationCubit, BaseStates>(
        builder: (context, state) {
         final cubit = AddNotificationCubit.get(context);
         return Scaffold(
          body: CustomPadding(
          withPattern: true,
          widget:Column(
          children: [
           CustomAppBar(text: LocaleKeys.newNotification.tr()),
            state is BaseStatesErrorState ?
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Center(
                    child: CustomShowMessage(
                      title: state.msg,
                      onPressed: () {
                        cubit.getNotificationType();
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ):
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height()*0.01),
                    Text(LocaleKeys.title.tr(), style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14),),
                    CustomTextField(controller: cubit.titleController,hintText: LocaleKeys.notifyTitle.tr(),type: TextInputType.text,),
                    SizedBox(height: height()*0.02),
                    Text(LocaleKeys.time.tr(), style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14),),
                    const ChooseTime(),
                    SizedBox(height: height()*0.02),
                    Text(LocaleKeys.repeat.tr(), style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14)),
                    SizedBox(height: height()*0.02),
                    state is BaseStatesLoadingState ?  Padding(
                      padding: EdgeInsetsDirectional.only(start: width()*0.37),
                      child: const CustomLoading(),
                    ):
                    DropDownBorderItem(
                        items: List.generate(
                            cubit.notificationTypeModel!.data!.length,
                                (index) => DropdownMenuItem<String>(
                                value: cubit.notificationTypeModel!.data![index].id.toString(),
                                child: Text(cubit.notificationTypeModel!.data![index].name.toString(),
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),))),
                         onChanged: (value) {
                          cubit.changeRepeat(value);
                        },
                        dropDownValue: cubit.chooseRepeat,
                         hint: LocaleKeys.repeat.tr()),
                    SizedBox(height: height()*0.15),
                    Row(
                      children: [
                        state is BaseStatesSubmitState ?  Padding(
                          padding: EdgeInsetsDirectional.only(start: width()*0.37),
                          child: const CustomLoading(),
                        ):
                        Expanded(child: CustomBtn(title: LocaleKeys.save.tr(), onTap: (){
                          cubit.addNotify();
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