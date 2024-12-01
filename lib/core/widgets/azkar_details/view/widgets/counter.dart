import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/size.dart';



class CounterAzkar extends StatelessWidget {
  final int count;
  final void Function()? onTap;
  final double percent;
  const CounterAzkar({super.key, required this.count, this.onTap, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircularPercentIndicator(
            radius: AppRadius.r40,
            animation: true,
            lineWidth: width() * 0.016,
            percent: percent,
            center: Text(count.toString(), style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t40),),
            progressColor: Colors.green,
          ),
        ),
        SizedBox(height: width() * 0.015),
        Text(context.locale.languageCode=="ar"? "عدد مرات الذكر : $count" :"Counter : $count", style: TextStyle(
            color: AppColors.greenColor, fontSize: AppFonts.t14
        ),)
      ],
    );
  }
}
