import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/screens/btmNavBar/view/widgets/btm_nav_bar_body.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/size.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/my_navigate.dart';
import '../../../on_boarding/view/on_boarding_view.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      navigateAndFinish( widget:CacheHelper.getData(key: AppCached.token)==null?const OnBoardingScreen() : const CustomBtmNavBar());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashBg),
            fit: BoxFit.fill,
          ),
        ),
        child: ZoomIn(
          duration: const Duration(seconds: 3),
          child:
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.splashLogo,
                  width: width() * 0.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


