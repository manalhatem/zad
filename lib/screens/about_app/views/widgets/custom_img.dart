import 'package:flutter/material.dart';

import '../../../../core/utils/size.dart';

class CustomImage extends StatelessWidget {
  final String img;
  const CustomImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: width()*0.08),
      width: width()*0.32,
      height:  width()*0.32,
      decoration: BoxDecoration(
          image:  DecorationImage(
              image: NetworkImage(img),fit: BoxFit.fill
          ),
          borderRadius: BorderRadius.circular(AppRadius.r8)
      ),);
  }
}
