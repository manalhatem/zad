import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/generated/locale_keys.g.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import 'qiblah_compass.dart';



class CustomCompass extends StatefulWidget {
  const CustomCompass({super.key});

  @override
  State<CustomCompass> createState() => _CustomCompassState();
}

class _CustomCompassState extends State<CustomCompass> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _deviceSupport,
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading(fullScreen: true,);
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );
        }
        if (snapshot.data!) {
          return const QiblahCompass();
        }
        else {
          return  Column(
            children: [
              SizedBox(height: height()*0.04),
             SvgPicture.asset(AppImages.noCompass,width: width()*0.65),
              SizedBox(height: height()*0.04),
              Text(LocaleKeys.qiblaNotSupported.tr(),style:  TextStyle(
                  color: AppColors.greenColor,
                  fontSize: AppFonts.t18)),
            ],
          );
        }
      },
    );
  }
}
