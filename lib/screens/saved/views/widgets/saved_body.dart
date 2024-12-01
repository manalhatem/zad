import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_error_widget.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/screens/saved/views/widgets/saved_item.dart';
import '../../../../core/local/boxes.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../home/model/continue_reading_model.dart';
import '../../controller/saved_cubit.dart';

class SavedBody extends StatelessWidget {
  const SavedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => SavedCubit()..fetchSaved(),
        child: BlocBuilder<SavedCubit, BaseStates>(
            builder: (context, state) {
              final cubit = SavedCubit.get(context);
              return state is BaseStatesLoadingState ? const CustomLoading(fullScreen: true,):
              state is BaseStatesErrorState ?Column(
                children: [
                  const Spacer(),
                  Center(
                    child: CustomShowMessage(
                      title: state.msg,
                      onPressed: () {
                        cubit.fetchSaved();
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ):
              Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget:Column(
                    children: [
                      CustomAppBar(text: LocaleKeys.saved_.tr(),withBack: false),
                      Container(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: width()*0.05,vertical:width()*0.05),
                        margin: EdgeInsetsDirectional.only(top: width()*0.1),
                        decoration: BoxDecoration(
                          color: Theme.of(context).unselectedWidgetColor,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                          border: Border.all(color: AppColors.grayColor2.withOpacity(.5)),
                        ),
                        child:
                        Column(
                          children: [
                          SavedItem(
                          isLast: false,
                            faselName: LocaleKeys.saveRed.tr(),
                            faselSubTitle: Hive.box<ContinueReadingModel>(AppBox.faselRedBox).values.isEmpty?"":"${Hive.box<ContinueReadingModel>(AppBox.faselRedBox).values.first.suraName.toString()} ${Hive.box<ContinueReadingModel>(AppBox.faselRedBox).values.first.ayaNum.toString()}",
                            img: AppImages.redSave ,
                            onTap:() => cubit.onTap(boxName: AppBox.faselRedBox),),
                          SavedItem(
                          isLast: false,
                            faselName: LocaleKeys.saveBlue.tr(),
                            faselSubTitle: Hive.box<ContinueReadingModel>(AppBox.faselBlueBox).values.isEmpty?"":"${Hive.box<ContinueReadingModel>(AppBox.faselBlueBox).values.first.suraName.toString()} ${Hive.box<ContinueReadingModel>(AppBox.faselBlueBox).values.first.ayaNum.toString()}",
                            img: AppImages.blueSave ,
                            onTap:() => cubit.onTap(boxName: AppBox.faselBlueBox),),
                          SavedItem(
                          isLast: true,
                            faselName: LocaleKeys.saveYellow.tr(),
                            faselSubTitle: Hive.box<ContinueReadingModel>(AppBox.faselYellowBox).values.isEmpty?"":"${Hive.box<ContinueReadingModel>(AppBox.faselYellowBox).values.first.suraName.toString()} ${Hive.box<ContinueReadingModel>(AppBox.faselYellowBox).values.first.ayaNum.toString()}",
                            img: AppImages.yellowSave ,
                            onTap:() => cubit.onTap(boxName: AppBox.faselYellowBox),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
