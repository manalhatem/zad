import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/cant_change_lang_dialog.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_padding.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/alward_alsarie/controller/alward_alsarie_cubit.dart';
import 'package:zad/screens/home/controller/home_cubit.dart';
import 'package:zad/screens/home/view/widgets/continue_reading.dart';
import 'package:zad/core/widgets/custom_drawer.dart';
import 'package:zad/screens/home/view/widgets/custom_home_header.dart';
import 'package:zad/screens/home/view/widgets/custom_home_list.dart';
import 'package:zad/screens/home/view/widgets/quraan_benefit.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/my_navigate.dart';
import '../../../alward_alsarie/views/alward_alsarie_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (_) => HomeCubit()..fetchDate(),
      child: BlocBuilder<HomeCubit,HomeStates>(
          builder: (context,state) {
            final cubit = BlocProvider.of<HomeCubit>(context);
            return ShowCaseWidget(
              enableShowcase: CacheHelper.getData(key: AppCached.enableShowcase)==false?false:true,
              onComplete: (p0, p1) => CacheHelper.saveData(key: AppCached.enableShowcase, value: false),
              builder: (context) =>Builder(
                  key: cubit.showCaseWidgets,
                  builder: (context) {
                    return Scaffold(
                      key: cubit.key,
                      endDrawerEnableOpenDragGesture: true,
                      endDrawer:  CustomDrawer(
                        onTap: (){
                          navigateTo(widget: const AlwardAlsarieScreen());
                        }, fromHome: true,),
                      body:  state is HomeLoadingState?const Center(child: CustomLoading(fullScreen: true,)) :
                      SafeArea(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: [
                                    CustomPadding(
                                      widget:  Column(
                                        children:  [
                                          CacheHelper.getData(key: AppCached.enabledLocation)==false||cubit.hours==null?
                                          InkWell(
                                            onTap: () => cubit.checkLocationServices(),
                                            child: FittedBox(child: Text(LocaleKeys.seePrayer.tr(),style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t14),)),
                                          ):
                                          const CustomHomeHeader(),
                                          const CustomHomeList(),
                                          const ContinueReading(),
                                          const QuraanBenefit(),
                                        ],
                                      ),
                                    ),
                                    Showcase(
                                      key: cubit.three,
                                      description: LocaleKeys.toPlayList.tr(),
                                      descTextStyle: TextStyle(fontSize: AppFonts.t16),
                                      child: InkWell(
                                        onTap: (){
                                          context.locale.languageCode=="en"?
                                          showDialog(
                                            context: context,
                                            builder: (context) => const CantChangeLangDialog(),
                                          ):
                                          cubit.key.currentState!.openEndDrawer();
                                        },
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.orangeCol,
                                                borderRadius:
                                                context.locale.languageCode=="ar"?
                                                BorderRadius.only(
                                                    bottomRight: Radius.circular(AppRadius.r11),
                                                    bottomLeft: Radius.circular(AppRadius.r11)
                                                ):
                                                BorderRadius.only(
                                                    topLeft: Radius.circular(AppRadius.r11),
                                                    topRight: Radius.circular(AppRadius.r11)
                                                )
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: width()*0.03,vertical: height()*0.01),
                                            child: Text(LocaleKeys.choseAndListen.tr(),style: TextStyle(color: Colors.white,fontSize: AppFonts.t14),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlocConsumer<SoraDetailsCubit,SoraDetailsStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  final tCubit = BlocProvider.of<SoraDetailsCubit>(context);
                                  return Align(
                                    alignment:AlignmentDirectional.bottomCenter,
                                    child:!tCubit.isPlaying ? const SizedBox.shrink() : Container(
                                      color: AppColors.greenWhiteClr,
                                      padding: EdgeInsets.symmetric(horizontal: width()*0.02,vertical: height()*0.01),
                                      child: Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(AppImages.suraNum,scale: 2.5,),
                                              Text(CacheHelper.getData(key: AppCached.soraNum).toString(),style: TextStyle(fontSize: AppFonts.t10,color: AppColors.greenColor),),
                                            ],
                                          ),
                                          SizedBox(width: width()*0.02,),
                                          Text(CacheHelper.getData(key: AppCached.soraName).toString(),style: TextStyle(fontSize: AppFonts.t14,color: AppColors.greenColor,fontFamily: "Amiri"),),
                                          const Spacer(),
                                          InkWell(
                                            onTap: ()async{
                                              tCubit.ppplay?await tCubit.pause():await tCubit.play(fromDetails: false);
                                            },
                                            child: Image.asset(!tCubit.ppplay?AppImages.playIcn : AppImages.pause, scale: 3),
                                          ),
                                          GestureDetector(
                                            onTap: () => tCubit.stop(),
                                            child: Container(
                                              padding: EdgeInsets.all(width()*0.015),
                                              margin: EdgeInsetsDirectional.only(start: width()*0.03),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: AppColors.greenColor,width: 2)
                                              ),
                                              child: Icon(Icons.close,color: AppColors.greenColor,size: width()*0.07,),
                                            ),
                                          )
                                        ],),
                                    ),
                                  );
                                }
                            ),
                            BlocConsumer<AlwardAlsarieCubit,AlwerdAlsarieStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  final alwardCubit = BlocProvider.of<AlwardAlsarieCubit>(context);
                                  return Align(
                                    alignment:AlignmentDirectional.bottomCenter,
                                    child:!alwardCubit.isPlay ? const SizedBox.shrink() : Container(
                                      color: AppColors.greenWhiteClr,
                                      padding: EdgeInsets.symmetric(horizontal: width()*0.02,vertical: height()*0.01),
                                      margin: EdgeInsets.only(bottom: width()*0.05),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width()*0.12,
                                            height: height()*0.06,
                                            alignment: Alignment.center,
                                            margin: EdgeInsetsDirectional.only(end: width()*0.02),
                                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                                            child: Text(
                                              CacheHelper.getData(key: AppCached.aOrq)=="zekr"?
                                              LocaleKeys.a.tr() : LocaleKeys.q.tr(),style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t20),),
                                          ),
                                          SizedBox(width: width()*0.02,),
                                          Text(CacheHelper.getData(key: AppCached.nameOfPlayList).toString(),style: TextStyle(fontSize: AppFonts.t14,color: AppColors.greenColor,fontFamily: "Amiri"),),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () => alwardCubit.prevPlay(),
                                            child: Transform.flip(
                                                flipX:context.locale.languageCode=="ar"?false: true,
                                                child: Image.asset(AppImages.prevIcn, scale: 3)),
                                          ),
                                          InkWell(
                                            onTap: ()async{
                                              alwardCubit.playLists[alwardCubit.currentPlayList]!.playing? alwardCubit.pause(): alwardCubit.resume();
                                            },
                                            child: Image.asset(
                                                alwardCubit.playing? AppImages.pause : AppImages.playIcn
                                                , scale: 3),
                                          ),
                                          InkWell(
                                            onTap: () => alwardCubit.nextPlay(),
                                            child: Transform.flip(
                                                flipX: context.locale.languageCode=="ar"?false: true,
                                                child: Image.asset(AppImages.nextIcn, scale: 3)),
                                          ),
                                          GestureDetector(
                                            onTap: () => alwardCubit.stop(),
                                            child: Container(
                                              padding: EdgeInsets.all(width()*0.015),
                                              margin: EdgeInsetsDirectional.only(start: width()*0.03),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: AppColors.greenColor,width: 2)
                                              ),
                                              child: Icon(Icons.close,color: AppColors.greenColor,size: width()*0.07,),
                                            ),
                                          )
                                        ],),
                                    ),
                                  );
                                }
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),

            );
          }
      ),
    );
  }
}
