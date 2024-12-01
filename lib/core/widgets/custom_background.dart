import 'package:flutter/material.dart';
import '../local/app_cached.dart';
import '../local/cache_helper.dart';
import '../utils/dark_image.dart';
import '../utils/images.dart';

class CustomBackground extends StatelessWidget {
  final Widget widget;

  const CustomBackground({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme
                  ? DarkAppImages.background
                  : AppImages.background),
          fit: BoxFit.fill,
        )),
        child: widget);
  }
}
