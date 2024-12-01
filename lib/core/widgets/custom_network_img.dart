import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/images.dart';

class CustomNetworkImg extends StatelessWidget {
  const CustomNetworkImg(
      {super.key, required this.img, required this.width, this.height, this.boxFit=true});
  final String img;
  final double width;
  final double? height;
  final bool? boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      img,
      width: width,
      height: height,
      fit:boxFit! == false ?null: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
        AppImages.errorImage,
        width: width,
        height: height,
        fit: BoxFit.scaleDown,
        matchTextDirection: true,
      ),
    );
  }
}
