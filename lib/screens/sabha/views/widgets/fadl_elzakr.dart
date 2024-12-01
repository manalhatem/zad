import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/sabha_cubit.dart';
import '../../controller/sabhq_state.dart';

class FadlElzakr extends StatelessWidget {
  const FadlElzakr({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SabhaCubit, SabhaState>(
        builder: (context, state) {
      final cubit = SabhaCubit.get(context);
      return Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(LocaleKeys.zekrFavor.tr(), style: Theme.of(context).textTheme.titleMedium),
            ),
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: width()*0.04,vertical:width()*0.05),
              margin: EdgeInsetsDirectional.only(top: width()*0.025),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.r11),
                  border: Border.all(color: AppColors.noActiveCol)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cubit.fadlElZekrModel!.data![0].content.toString(),
                    style: TextStyle(
                        fontSize: AppFonts.t14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Amiri",
                        color: Theme.of(context).primaryColorLight
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: width()*0.03),
                  Divider(color: Theme.of(context).dividerColor,),
                  SizedBox(height: width()*0.01),
                 HtmlWidget(cubit.fadlElZekrModel!.data![0].benefits.toString())
                  // Text("عن أبي هريرة رضي الله عنه: عن النبي – صلى الله عليه وسلم – قال: “كلمتان خفيفتان على اللسان، ثقيلتان في الميزان، حبيبتان إلى الرحمن، سبحان الله وبحمده سبحان الله العظيمِ",
                  //   style: TextStyle(
                  //       fontSize: AppFonts.t12,
                  //       color: AppColors.grayColor3
                  //   ),
                  //   textAlign: TextAlign.justify,
                  // ),
                  // SizedBox(height: width()*0.016),
                  // Text("متفق عليه",
                  //   style: TextStyle(
                  //       fontSize: AppFonts.t10,
                  //       color: AppColors.orangeCol
                  //   ),
                  // ),

                ],
              ),
            )
          ]);
        });
  }
}
