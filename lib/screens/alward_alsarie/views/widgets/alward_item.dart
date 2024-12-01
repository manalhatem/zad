import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/alward_alsarie/controller/alward_alsarie_cubit.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/my_navigate.dart';
import '../../../../core/utils/size.dart';
import '../../../sabha/views/widgets/custom_orange_btn.dart';

class AlwardItem extends StatelessWidget {
  final void Function()? onTapEdit , onAdd;
  final int idx , id;
  const AlwardItem({super.key, required this.idx, required this.onAdd, this.onTapEdit, required this.id});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AlwardAlsarieCubit, AlwerdAlsarieStates>(
      builder: (context,state) {
        final cubit = BlocProvider.of<AlwardAlsarieCubit>(context);
        return Container(
          padding:  EdgeInsetsDirectional.symmetric(horizontal:width()*0.02,vertical: width()*0.02),
          decoration: BoxDecoration(
              color: const Color(0xff9EC38F),
              borderRadius: BorderRadius.circular(AppRadius.r11)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(cubit.tracksModel!.data![idx].title.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: AppFonts.t16
                  ),),
                  SizedBox(width:  width()*0.02,),
                  Text("${cubit.tracksModel!.data![idx].tracks!.length} Tracks", style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: AppFonts.t10)),
                  const Spacer(),
                  InkWell(
                      onTap: onAdd,
                      child: SvgPicture.asset(AppImages.addList,width: width()*0.07)),
                  SizedBox(width: width()*0.02,),
                  InkWell(
                      onTap:onTapEdit,
                      child: SvgPicture.asset(AppImages.greenEdit,width: width()*0.07)),
                  SizedBox(width: width()*0.02,),
                  InkWell(
                      onTap: (){
                        cubit.playLists[idx]!.playing?
                        showToast(text: LocaleKeys.cantDel.tr(), state:ToastStates.error):
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.symmetric(horizontal: width() * .05),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(AppRadius.r8)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: width() * .06, vertical: height() * .04),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "هل أنت متأكد من حذف هذا الورد ؟",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    height: height() * .04,
                                  ),
                                  Row(
                                    children: [
                                      state is DeleteWerdLoadingState?
                                      const CustomLoading(fullScreen: false,):
                                      Expanded(
                                        child: CustomOrangeBtn(
                                            title: LocaleKeys.delete.tr(), onTap: () => cubit.deleteTrack(id: id, index: idx), type: BtnType.orange),
                                      ),
                                      SizedBox(
                                        width: width() * .03,
                                      ),
                                      Expanded(
                                        child: CustomOrangeBtn(
                                            title: LocaleKeys.cancelVal.tr(), onTap: () { navigatorPop( ); }, type: BtnType.opacityOrange),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(AppImages.greenDelete,width: width()*0.07)),
                ],
              ),
              SizedBox(height: height()*0.02,),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => DecoratedBox(
                    decoration: BoxDecoration(
                      color:cubit.currentPlayList==idx && cubit.currentAudio==index? Colors.white24 : Colors.transparent
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: width()*0.12,
                          height: height()*0.06,
                          alignment: Alignment.center,
                          margin: EdgeInsetsDirectional.only(end: width()*0.02),
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            cubit.tracksModel!.data![idx].tracks![index].type.toString()=="zekr"?
                            LocaleKeys.a.tr() : LocaleKeys.q.tr(),style: TextStyle(color: AppColors.greenColor,fontSize: AppFonts.t20),),
                        ),
                        Expanded(
                          child: Text(
                              cubit.tracksModel!.data![idx].tracks![index].title.toString()
                              , style: TextStyle(
                              color: AppColors.blackColor,fontWeight: FontWeight.bold,
                              fontSize: AppFonts.t14,fontFamily: "Amiri")),
                        ),
                        GestureDetector(
                            onTap: () => cubit.playAudio(playListIndex: idx , songIndex: index),
                            child: Image.asset(AppImages.playIcn, scale: 4,))
                      ],
                    ),
                  ),
                  separatorBuilder:(context, index) => SizedBox(height: height()*0.01,),
                  itemCount: cubit.tracksModel!.data![idx].tracks!.length),
            ],
          ),

        );
      }
    );
  }
}
