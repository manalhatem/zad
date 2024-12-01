import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/widgets/custom_app_bar.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_padding.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/quraan/controller/quraan_cubit.dart';
import 'package:zad/screens/quraan/view/widgets/parts_body.dart';
import 'package:zad/screens/quraan/view/widgets/quarters_body.dart';
import 'package:zad/screens/quraan/view/widgets/quraan_sections.dart';
import 'package:zad/screens/quraan/view/widgets/sowar_body.dart';

class QuraanScreen extends StatelessWidget {
  const QuraanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => QuraanCubit()..fetchScreen(),
        child: BlocBuilder<QuraanCubit,QuraanStates>(
          builder: (context,state) {
            final cubit = BlocProvider.of<QuraanCubit>(context);
            return CustomPadding(
              withPattern: true,
              widget: state is QuraanLoadingState?
              const CustomLoading(fullScreen: true,):Column(
                children: [
                  CustomAppBar(text: LocaleKeys.qauraan.tr()),
                  const QuraanSections(),
                  cubit.currentBtn==0?
                  const SowarBody():
                  cubit.currentBtn==1?
                  const QuartersBody():
                  const PartsBody()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
