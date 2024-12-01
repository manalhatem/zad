import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../about_app/views/widgets/custom_container.dart';
import '../../../about_app/views/widgets/custom_img.dart';
import '../../controller/privacy_cubit.dart';


class PrivacyBody extends StatelessWidget {
  const PrivacyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => PrivacyCubit()..getPrivacy(),
        child: BlocBuilder<PrivacyCubit, BaseStates>(
        builder: (context, state) {
         final cubit = PrivacyCubit.get(context);
         return Scaffold(
          body: CustomPadding(
          withPattern: true,
          widget:Column(
          children: [
           CustomAppBar(text: LocaleKeys.privacyPolicy.tr()),
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
                        cubit.getPrivacy();
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
                   CustomImage(img:cubit.privacyModel!.data!.logo!),
                  SizedBox(height: height()*0.02),
                  CustomStaticContainer(widget:Text(cubit.privacyModel!.data!.privacyPolicy.toString(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: AppFonts.t14),textAlign: TextAlign.center,),
                  ),
                ],
              ),
            )






          ])));}));
  }
}
