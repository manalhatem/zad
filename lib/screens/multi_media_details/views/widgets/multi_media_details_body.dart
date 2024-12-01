import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/empty_list.dart';
import 'package:zad/generated/locale_keys.g.dart';

import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../controller/multi_media_details_cubit.dart';
import 'multi_media_details_item.dart';

class MultiMediaDetailsBody extends StatelessWidget {
  final int id;
  final String name;

  const MultiMediaDetailsBody({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => MultiMediaDetailsCubit()..getMultimediaDetails(id: id.toString()),
        child: BlocBuilder<MultiMediaDetailsCubit, BaseStates>(
            builder: (context, state) {
              final cubit = MultiMediaDetailsCubit.get(context);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                       CustomAppBar(text: name),
                      state is BaseStatesLoadingState ? const CustomLoading(fullScreen: true):
                      state is BaseStatesErrorState ?
                      Expanded(
                        child: Column(
                          children: [
                            const Spacer(),
                            Center(
                              child: CustomShowMessage(
                                title: state.msg,
                                onPressed: () {
                                  cubit.getMultimediaDetails(id: id.toString());
                                },
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ):
                          cubit.multimediaDetailsModel!.data!.isEmpty?
                            Expanded(child: EmptyList(img: AppImages.noVideo, text: LocaleKeys.noVideos.tr())):
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
                              img:cubit.multimediaDetailsModel!.data![index].image! ,
                              title: cubit.multimediaDetailsModel!.data![index].desc.toString(),
                              subTitle: cubit.multimediaDetailsModel!.data![index].name.toString(),
                              isFav: cubit.multimediaDetailsModel!.data![index].fav!,
                              media: cubit.multimediaDetailsModel!.data![index].media.toString(),
                              type: cubit.multimediaDetailsModel!.data![index].type.toString(),
                              onTapFav: (){
                                cubit.toggleFav(id: cubit.multimediaDetailsModel!.data![index].id!, index: index);
                              },
                              );
                          },
                          itemCount:cubit.multimediaDetailsModel!.data!.length,
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }));
  }
}
