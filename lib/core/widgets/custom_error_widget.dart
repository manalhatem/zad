import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/widgets/custom_btn.dart';

import '../../generated/locale_keys.g.dart';
import '../remote/my_dio.dart';
import '../utils/images.dart';
import '../utils/size.dart';


class CustomShowMessage extends StatelessWidget {
  const CustomShowMessage(
      {super.key,
        required this.title,
        this.onPressed,
        this.top = 0,
        this.bottom = 0,
        this.start = 0,
        this.end = 0});
  final String title;
  final double top, bottom, start, end;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: top, bottom: bottom, start: start, end: end),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            title == globalError(context.locale.languageCode)
                ? AppImages.noInternet
                : title == noInternet(context.locale.languageCode)
                ? AppImages.noInternet
                : AppImages.globalError,
            width: width() * .35,
            height: height() * .17,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height() * .035,
                horizontal: width() * .05),
            child: Text(title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: AppFonts.t14,
                    height: height() * 0.002,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center),
          ),
          if (onPressed != null)
            CustomBtn(
                title: LocaleKeys.tryAgain.tr(), onTap: onPressed!, type: BtnType.selected),
          SizedBox(
            height: height() * .03,
          )
        ],
      ),
    );
  }
}