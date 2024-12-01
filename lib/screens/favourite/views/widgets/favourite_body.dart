import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/screens/favourite/views/widgets/remembrances_item.dart';
import 'package:zad/screens/favourite/views/widgets/video_fav_item.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/my_navigate.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/azkar_details/view/azkar_details_screen.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/empty_list.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../azkar_sub/view/azkar_sub_screen.dart';
import '../../../multi_media_details/views/widgets/show_video_in_app.dart';
import '../../controller/favourite_cubit.dart';
import 'custom_toggle_fav.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => FavouriteCubit()..getFavourite(),
        child: BlocBuilder<FavouriteCubit, BaseStates>(
            builder: (context, state) {
              final cubit = FavouriteCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      CustomAppBar(text: LocaleKeys.favourite_.tr(),withBack: false),
                      state is BaseStatesErrorState ?const SizedBox.shrink():  const CustomToggleFav(),
                      state is BaseStatesErrorState ?
                      Expanded(
                        child: Column(
                          children: [
                            const Spacer(),
                            Center(
                              child: CustomShowMessage(
                                title: state.msg,
                                onPressed: () {
                                  cubit.getFavourite();
                                },
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ):
                      Expanded(
                        child:cubit.currentIndex==0?
                            state is BaseStatesLoadingState || cubit.favouriteModel==null?const CustomLoading(fullScreen: true):
                            cubit.favouriteModel!.data!.azkar!.isEmpty ?
                            EmptyList(img: AppImages.emptyFav,text: LocaleKeys.noFavItem.tr()):
                        ListView.separated(itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              cubit.favouriteModel!.data!.azkar![index].hasChildren==true?
                              navigateToWithPadding( widget:AzkarSubScreen(id: cubit.favouriteModel!.data!.azkar![index].id!,
                                  title: cubit.favouriteModel!.data!.azkar![index].name.toString())):
                              cubit.getAzkar(id: cubit.favouriteModel!.data!.azkar![index].id!).then((value) {
                                navigateToWithPadding(
                                    widget:  AzkarDetailsScreen(
                                        title: cubit.favouriteModel!.data!.azkar![index].name.toString(),
                                        fromAzkar: true, list: const [],listAzkar: cubit.azkarModel!.data!.azkar!,
                                      isFav: cubit.azkarModel!.data!.fav!,
                                      id: cubit.favouriteModel!.data!.azkar![index].id!,
                                    fun: (value)=>cubit.getFavourite(),));
                              });
                            },
                              child:RemembrancesItem(img: cubit.favouriteModel!.data!.azkar![index].image!,
                                text:cubit.favouriteModel!.data!.azkar![index].name.toString(),
                                id: cubit.favouriteModel!.data!.azkar![index].id!,));
                        }, separatorBuilder: (context, index){
                          return const Divider(color: AppColors.orangeWithOpacity);
                        }, itemCount: cubit.favouriteModel!.data!.azkar!.length):
                        state is BaseStatesLoadingState || cubit.favouriteModel==null ?const CustomLoading(fullScreen: true):
                        cubit.favouriteModel!.data!.media!.isEmpty ?
                        EmptyList(img: AppImages.emptyFav,text: LocaleKeys.noFavItem.tr()):
                        GridView.builder(
                          padding: EdgeInsetsDirectional.symmetric(vertical: width() * 0.07),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .78,
                              crossAxisSpacing: width() * 0.028,
                              mainAxisSpacing: width() * 0.028),
                          itemBuilder: (context, index) {
                            return   GestureDetector(
                              onTap: cubit.favouriteModel!.data!.media![index].type=='link'? ()async {
                                if (!await launchUrl(Uri.parse(cubit.favouriteModel!.data!.media![index].media!))) {
                                  throw 'Could not launch';
                                } else {
                                  return  ;
                                }
                              }:(){
                                navigateTo(widget: ShowVideoInApp(path: cubit.favouriteModel!.data!.media![index].media!,
                                    title: cubit.favouriteModel!.data!.media![index].desc.toString()));
                              },
                              child: VideoFavItem(
                                img: cubit.favouriteModel!.data!.media![index].image!,
                                title: cubit.favouriteModel!.data!.media![index].desc.toString(),
                                subTitle:cubit.favouriteModel!.data!.media![index].name.toString(),
                                isFav: cubit.favouriteModel!.data!.media![index].fav!,
                                type: cubit.favouriteModel!.data!.media![index].type!,
                              onTapFav: (){cubit.toggleFav(id: cubit.favouriteModel!.data!.media![index].id!,
                                  index: index,
                                  type: cubit.favouriteModel!.data!.media![index].favType!);}),
                            );
                          },
                          itemCount:cubit.favouriteModel!.data!.media!.length,

                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
