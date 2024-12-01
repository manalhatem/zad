import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_app_bar.dart';
import 'package:zad/core/widgets/custom_row.dart';
import '../../../core/utils/base_state.dart';
import '../../../core/widgets/azkar_details/view/azkar_details_screen.dart';
import '../../../core/widgets/custom_error_widget.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../../core/widgets/empty_list.dart';
import '../../../generated/locale_keys.g.dart';
import '../controller/azkar_sub_cubit.dart';

class AzkarSubScreen extends StatelessWidget {
  final int id;
 final String title;
  const AzkarSubScreen({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (cubitContext) => AzkarSubCubit()..getSubAzkar(id: id),
        child:
            BlocBuilder<AzkarSubCubit, BaseStates>(builder: (context, state) {
            final cubit = AzkarSubCubit.get(context);
             return Scaffold(
             body:  Column(
              children: [
                CustomAppBar(text: title),
                state is BaseStatesLoadingState ?
                const CustomLoading(fullScreen: true):
                state is BaseStatesErrorState ?
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(),
                      Center(
                        child: CustomShowMessage(
                          title: state.msg,
                          onPressed: () {
                            cubit.getSubAzkar(id: id);
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ):
                cubit.subAzkarModel!.data!.isEmpty ?
                EmptyList(img: AppImages.noZekr, text: LocaleKeys.noZekr.tr()):
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: height() * 0.02),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            cubit.getAzkar(id: cubit.subAzkarModel!.data![index].id!).then((value){
                              navigateToWithPadding(
                                  widget:  AzkarDetailsScreen(
                                    title: cubit.subAzkarModel!.data![index].name.toString(),
                                    fromAzkar: true, list: const [], listAzkar: cubit.azkarModel!.data!.azkar!,
                                    isFav: cubit.azkarModel!.data!.fav!,
                                    id: cubit.subAzkarModel!.data![index].id!,));
                            });
                          },
                          child: CustomRow(
                            text: cubit.subAzkarModel!.data![index].name.toString(),
                            img: cubit.subAzkarModel!.data![index].image!, networkImg: true,
                          )),
                      separatorBuilder: (context, index) => Divider(
                        color: AppColors.grayColor2.withOpacity(0.2),
                      ),
                      itemCount: cubit.subAzkarModel!.data!.length),
                )
              ],
            ),
          );
        }));
  }
}
