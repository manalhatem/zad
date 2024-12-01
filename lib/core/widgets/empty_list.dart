import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/size.dart';

class EmptyList extends StatelessWidget {
  final String img;
  final String text;

  const EmptyList({super.key, required this.img, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(img, width: width()*0.3,),
          SizedBox(height: height()*0.03),
          Text(text,
            style:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height()*0.09),
        ],
      ),
    );
  }
}
