import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../privacy/views/privacy_view.dart';
import '../../controller/about_app_cubit.dart';
import 'custom_container.dart';
import 'custom_img.dart';

class AboutAppBody extends StatelessWidget {
  const AboutAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => AboutAppCubit()..getAboutApp(),
        child: BlocBuilder<AboutAppCubit, BaseStates>(
        builder: (context, state) {
         final cubit = AboutAppCubit.get(context);
         return Scaffold(
          body: CustomPadding(
          withPattern: true,
          widget:Column(
          children: [
           CustomAppBar(text: LocaleKeys.aboutApp.tr()),
            state is BaseStatesLoadingState ? const CustomLoading(fullScreen: true):
                state is BaseStatesErrorState ?
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Center(
                    child: CustomShowMessage(
                      title: state.msg,
                      onPressed: () {
                        cubit.getAboutApp();
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ):
            Expanded(
              child: Column(
                children: [
                   CustomImage(img:cubit.aboutAppModel!.data!.logo!),
                  CustomStaticContainer(widget: Column(
                    children: [
                      Text(LocaleKeys.theNameApplication.tr(),style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14)),
                      SizedBox(height: width()*0.025),
                      Text(cubit.aboutAppModel!.data!.appVerse.toString(),style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t16,fontFamily: "Amiri"),),
                    ],
                  ),),
                  SizedBox(height: height()*0.02),
                  CustomStaticContainer(widget:Text(cubit.aboutAppModel!.data!.aboutApp.toString(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: AppFonts.t14),textAlign: TextAlign.center,),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: (){
                        navigateTo( widget: const PrivacyScreen());
                      },
                      child: Text(LocaleKeys.privacyPolicy.tr(),style:  TextStyle(color: AppColors.orangeCol,fontSize: AppFonts.t16),)),
                  SizedBox(height:width()*0.02),
                  Text("${LocaleKeys.release.tr()} 0.0.1",style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height:width()*0.08)
                ],
              ),
            )

          ])));}));
  }
}
