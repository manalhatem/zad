import 'package:flutter/material.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/size.dart';

class CustomIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;
  const CustomIndicator({super.key, required this.length, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
            (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: width() * .007),
          height: height() * .007,
          width: currentIndex == index
              ? width() * .1
              : height() * .007,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: currentIndex == index
                ? AppColors.orangeCol
                : AppColors.orangeWithOpacity,
          ),
        ),
      ),
    );
  }
}
