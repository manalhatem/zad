import 'package:flutter/material.dart';
import 'package:zad/core/utils/size.dart';

import '../utils/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading(
      {super.key, this.fullScreen = false, this.col});
  final bool fullScreen;
  final Color? col;

  @override
  Widget build(BuildContext context) {
    return fullScreen
        ? Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: height()*0.26),
          child: Center(
            child: Image.asset("assets/images/New-file-ezgif.com-speed (4).gif",scale: 4,),
          ),
        ): CircularProgressIndicator(
      color:col ?? AppColors.greenColor,
    );
  }
}