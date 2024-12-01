import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/base_state.dart';
import '../../../../../core/utils/size.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_network_img.dart';
import '../../controller/on_boarding_cubit.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, BaseStates>(
      builder: (context, state) {
        final cubit = OnBoardingCubit.get(context);
        return Expanded(
          child: PageView(
              controller: cubit.pageViewController,
              onPageChanged: (index) {
                cubit.pageChanged(i: index, list: cubit.onBoardingModel!.data!);
              },
              children: List.generate(
                  cubit.onBoardingModel!.data!.length,
                  (index) => Stack(
                    children: [
                      Container(
                          decoration:  const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.splashBg),
                                fit: BoxFit.fill,
                              )
                          )),
                      Positioned(
                          top: width()*0.29,
                          left: width()*0.15,
                          child: CustomNetworkImg(img:cubit.onBoardingModel!.data![index].imageOne!, width: width()*0.5
                           )),
                      Positioned(
                          top: width()*0.75,
                          left: width()*0.36,
                          child: CustomNetworkImg(img:cubit.onBoardingModel!.data![index].imageTwo!,width: width()*0.52)),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: width(),
                          height: height()*0.35,
                          decoration:  const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppImages.onBoardingBottom),fit: BoxFit.fill),),
                          child: Column(
                            children: [
                              SizedBox(height: height()*0.22),
                               Text(cubit.onBoardingModel!.data![index].name.toString(),style: const TextStyle(color: AppColors.blackColor),),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: width()*0.04,vertical:width()*0.03 ),
                                child: Text(cubit.onBoardingModel!.data![index].desc.toString(),style: TextStyle(color: AppColors.grayColor,
                                    fontSize:AppFonts.t14,height: 1.5),textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),

              )),
        );
      },
    );
  }
}
