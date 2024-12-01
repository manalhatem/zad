import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/sabha_cubit.dart';
import '../../controller/sabhq_state.dart';
import 'fadl_elzakr.dart';
import 'sabha_top_row.dart';
import 'text_counter.dart';

class SabhaBody extends StatelessWidget {
  const SabhaBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => SabhaCubit()..getAllZekr(),
        child: BlocBuilder<SabhaCubit, SabhaState>(
            builder: (context, state) {
              final cubit = SabhaCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                       CustomAppBar(text: LocaleKeys.electronicRosary.tr()),
                      Expanded(
                        child:
                        state is SabhaStateLoadingState ?const CustomLoading(fullScreen: true,):
                        state is SabhaStateErrorState ?
                        Center(
                        child: CustomShowMessage(
                        title: state.msg,
                          onPressed: () {
                            cubit.getAllZekr();
                          },
                          )):
                          SingleChildScrollView(
                          child: Column(
                            children: [
                              BlocProvider.value(value: context.read<SabhaCubit>(), child:  SabhaTopRow(ctx: context)),
                              cubit.userSelectZekr==null? const SizedBox():
                              BlocProvider.value(value: context.read<SabhaCubit>(), child: const TextAndCounter()),
                              SizedBox(height: height()*0.06),
                              cubit.userSelectZekr==null? const SizedBox(): cubit.user=="public"?
                                  state is LoadingfadlElzekrState || cubit.fadlElZekrModel==null ? const CustomLoading() :
                                  const FadlElzakr():const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
