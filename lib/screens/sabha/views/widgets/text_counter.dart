import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/utils/my_navigate.dart';
import '../../../../core/utils/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/sabha_cubit.dart';
import '../../controller/sabhq_state.dart';
import 'custom_orange_btn.dart';
import 'zero_counter_dialog.dart';

class TextAndCounter extends StatelessWidget {
  const TextAndCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SabhaCubit, SabhaState>(
        builder: (context, state) {
      final cubit = SabhaCubit.get(context);
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height()*0.14,bottom:height()*0.037),
            child: Text(cubit.userSelectZekr.toString(),
              style: TextStyle(
                  fontSize: AppFonts.t16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Amiri",
                  color: Theme.of(context).primaryColorLight
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          InkWell(
            onTap: (){
              cubit.addCounter();
            },
            child: CircularPercentIndicator(
              radius: AppRadius.r55,
              animation: true,
              lineWidth: width()*0.023,
              percent: 1,
              center:  Text("${cubit.number}",style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: AppFonts.t40
              ),),
              progressColor: Colors.transparent,
            ),
          ),
          SizedBox(height: height()*0.022),
          cubit.number==0?const SizedBox():
          CustomOrangeBtn(title: LocaleKeys.counterZero.tr(), onTap: () {
            showDialog(
              context: context,
              builder: (context) =>ZeroCounterDialog(onTap: () {cubit.zeroCounter();navigatorPop( );},),
            );
             },
              type: BtnType.orange),
        ],
      );
    });
  }
}
