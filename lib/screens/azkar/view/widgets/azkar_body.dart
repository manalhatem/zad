import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_app_bar.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/custom_row.dart';
import 'package:zad/core/widgets/custom_text_field.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/core/widgets/empty_list.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/azkar/controller/azkar_cubit.dart';
import 'package:zad/screens/azkar_sub/view/azkar_sub_screen.dart';
import '../../../../core/widgets/azkar_details/view/azkar_details_screen.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';

class AzkarBody extends StatelessWidget {
  const AzkarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..getAzkarCategory(),
      child: BlocBuilder<AzkarCubit,AzkarStates>(
        builder: (context,state) {
          final cubit = BlocProvider.of<AzkarCubit>(context);
          return Scaffold(
            body: CustomPadding(
              withPattern: true,
              widget: Column(
                children: [
                  CustomAppBar(text: LocaleKeys.remembrances.tr()),
                  state is LoadingAzkarState ?
                  const CustomLoading(fullScreen: true):
                  state is ErrorAzkarState ?
                  Expanded(
                    child: Column(
                      children: [
                        const Spacer(),
                        Center(
                          child: CustomShowMessage(
                            title: state.msg,
                            onPressed: () {
                              cubit.getAzkarCategory();
                            },
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ):
                  Expanded(
                    child: Column(
                      children: [
                        CustomTextField(controller: cubit.saerchCtrl,
                            onChanged: (p0) => cubit.checkStopTexting(),
                            type: TextInputType.text,suffixIcon: Padding(
                          padding:  EdgeInsets.all(width()*0.03),
                          child: SvgPicture.asset(AppImages.searchIcn),
                        )),
                        cubit.azkarCategoryModel!.data!.isEmpty ?
                        Expanded(child: EmptyList(img: AppImages.noZekr, text: LocaleKeys.noZekr.tr())):
                        Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: height()*0.02),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => InkWell(
                                  onTap: (){
                                    cubit.azkarCategoryModel!.data![index].hasChildren==true?
                                    navigateToWithPadding( widget:AzkarSubScreen(id: cubit.azkarCategoryModel!.data![index].id!,
                                      title: cubit.azkarCategoryModel!.data![index].name.toString())):
                                        cubit.getAzkar(id: cubit.azkarCategoryModel!.data![index].id!).then((value) {
                                          state is ErrorAzkarState ?
                                          showToast(text: state.msg, state: ToastStates.error):
                                          navigateToWithPadding(
                                              widget:  AzkarDetailsScreen(
                                                  title: cubit.azkarCategoryModel!.data![index].name.toString(),
                                                  fromAzkar: true, list: const [],listAzkar: cubit.azkarModel!.data!.azkar!,
                                                isFav: cubit.azkarModel!.data!.fav!,
                                                id: cubit.azkarCategoryModel!.data![index].id!));
                                        });
                                  },
                                  child:  CustomRow(
                                    text: cubit.azkarCategoryModel!.data![index].name.toString(),
                                    img: cubit.azkarCategoryModel!.data![index].image!, networkImg: true,
                                  )
                              ),
                              separatorBuilder: (context, index) =>  Divider(color: AppColors.grayColor2.withOpacity(0.2),),
                              itemCount: cubit.azkarCategoryModel!.data!.length),
                        )
                      ],
                    ),
                  )
                  
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
