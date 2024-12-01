import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_network_img.dart';
import 'package:zad/core/widgets/custom_text_field.dart';
import 'package:zad/core/widgets/empty_list.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../multi_media_details/views/multimedia_details_view.dart';
import '../../../multi_media_details/views/widgets/multi_media_details_item.dart';
import '../../controller/multi_media_cubit.dart';

class MultiMediaBody extends StatelessWidget {
  const MultiMediaBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => MultiMediaCubit()..getMultimedia(),
        child: BlocBuilder<MultiMediaCubit, BaseStates>(
            builder: (context, state) {
              final cubit = MultiMediaCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      CustomAppBar(text: LocaleKeys.media.tr()),
                        state is BaseStatesLoadingState ?const CustomLoading(fullScreen: true):
                        state is BaseStatesErrorState ?
                        Expanded(
                          child: Column(
                            children: [
                              const Spacer(),
                              Center(
                                child: CustomShowMessage(
                                  title: state.msg,
                                  onPressed: () {
                                    cubit.getMultimedia();
                                  },
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ):
                        Expanded(
                          child: Column(children: [
                            CustomTextField(suffixIcon:InkWell(
                              onTap: (){
                                if(cubit.searchCtl.text.isEmpty){
                                  showToast(text: LocaleKeys.enterwordSearch.tr(),state: ToastStates.error);
                                }
                                else{
                                  cubit.doneSearch(true);
                                  cubit.search();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(width()*0.03),
                                child: SvgPicture.asset(AppImages.searchIcn),
                              ),
                            ),controller: cubit.searchCtl,type: TextInputType.text),
                            cubit.doSearch==true ? GestureDetector(
                              onTap:(){
                                cubit.doneSearch(false);
                                cubit.searchCtl.clear();
                              },
                              child:const Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child:  Icon(Icons.close,color: AppColors.greenColor,)),
                            ):const SizedBox.shrink(),
                            cubit.doSearch==true?
                                state is BaseStatesSubmitState ? const CustomLoading():
                                    cubit.searchModel!.data!.isEmpty ?
                                        Padding(
                                          padding:  EdgeInsets.only(top: width()*0.28),
                                          child: const EmptyList(img: AppImages.noSearch, text: ""),
                                        ):
                            Expanded(
                              child: GridView.builder(
                                padding: EdgeInsetsDirectional.symmetric(vertical: width() * 0.07,horizontal:width() * 0.02 ),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .74,
                                    crossAxisSpacing: width() * 0.028,
                                    mainAxisSpacing: width() * 0.028),
                                itemBuilder: (context, index) {
                                  return  MultiMediaDetailsItem(
                                    img:cubit.searchModel!.data![index].image! ,
                                    title: cubit.searchModel!.data![index].desc.toString(),
                                    subTitle: cubit.searchModel!.data![index].name.toString(),
                                    isFav: cubit.searchModel!.data![index].fav!,
                                    media: cubit.searchModel!.data![index].media.toString(),
                                    type: cubit.searchModel!.data![index].type.toString(),
                                    onTapFav: (){
                                      cubit.toggleFav(id: cubit.searchModel!.data![index].id!, index: index);
                                    },
                                  );
                                },
                                itemCount:cubit.searchModel!.data!.length,
                              ),
                            ):
                            Expanded(
                              child: GridView.builder(
                                padding: EdgeInsetsDirectional.symmetric(vertical: width() * 0.07,horizontal:width() * 0.02 ),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .94,
                                    crossAxisSpacing: width() * 0.028,
                                    mainAxisSpacing: width() * 0.028),
                                itemBuilder: (context, index) {
                                  return  InkWell(
                                    onTap: (){
                                      cubit.changeColor(index);
                                      navigateTo(widget:MultiMediaDetailsScreen(id: cubit.multimediaModel!.data![index].id!,
                                        name:cubit.multimediaModel!.data![index].name.toString()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.greenColor.withOpacity(0.06),
                                          borderRadius: BorderRadius.circular(AppRadius.r8),
                                          border: Border.all(color: cubit.currentIndex==index? AppColors.greenColor:Colors.transparent)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomNetworkImg(img:cubit.multimediaModel!.data![index].image!,width: width()*0.3,),
                                          SizedBox(height: height()*0.022),
                                          Text(cubit.multimediaModel!.data![index].name.toString(), style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              fontSize: AppFonts.t14
                                          ),),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount:cubit.multimediaModel!.data!.length,
                              ),
                            ),
                          ],),
                        )
                    ],
                  ),
                ),
              );
            }));
  }
}
