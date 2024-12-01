import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/my_navigate.dart';
import '../../../../core/widgets/azkar_details/view/azkar_details_screen.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/supplications_cubit.dart';

class SupplicationsBody extends StatelessWidget {
  const SupplicationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => SupplicationsCubit(),
        child: BlocBuilder<SupplicationsCubit, BaseStates>(
            builder: (context, state) {
              final cubit = SupplicationsCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      CustomAppBar(text: LocaleKeys.supplications.tr()),
                      SizedBox(height: height()*0.08),
                      state is BaseStatesLoadingState ?const CustomLoading(fullScreen: true):
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                                onTap: (){
                                  cubit.getSupplications(id: 1).then((value) =>
                                  cubit.supplicationsModel==null ?
                                  showToast(text: LocaleKeys.noSupplication.tr(),state: ToastStates.error):
                                  navigateToWithPadding(widget:  AzkarDetailsScreen(title: LocaleKeys.supplicationsFromQuran.tr(),
                                      list: cubit.supplicationsModel!.data!, listAzkar: const [], isFav: false, id: 1,))
                                  );},
                                child: SvgPicture.asset(AppImages.quran)),
                            Padding(
                              padding: EdgeInsets.only(top:height()*0.025,bottom:height()*0.045),
                              child: Text(LocaleKeys.supplicationsFromQuran.tr(),style: Theme.of(context).textTheme.titleMedium),
                            ),
                            InkWell(
                                onTap: (){
                                  cubit.getSupplications(id: 2).then((value) {
                                     cubit.supplicationsModel==null ?
                                    showToast(text: LocaleKeys.noSupplication.tr(),state: ToastStates.error):
                                    navigateToWithPadding(widget:  AzkarDetailsScreen(title: LocaleKeys.supplicationsFromSunnah.tr(),
                                        list: cubit.supplicationsModel!.data!, listAzkar: const [], isFav: false, id: 1,));
                                  });
                                },
                                child: Image.asset(AppImages.sunah)),
                            Padding(
                              padding: EdgeInsets.only(top:height()*0.025,bottom:height()*0.045),
                              child: Text(LocaleKeys.supplicationsFromSunnah.tr(),style: Theme.of(context).textTheme.titleMedium),
                            )
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
