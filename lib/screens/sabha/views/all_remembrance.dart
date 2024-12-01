import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/screens/sabha/views/widgets/add_zekr.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/utils/colors.dart';
import '../controller/sabha_cubit.dart';
import '../controller/sabhq_state.dart';

class AllRemembrance extends StatelessWidget {
  const AllRemembrance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => SabhaCubit()..getAllZekr(),
        child: BlocBuilder<SabhaCubit, SabhaState>(
            builder: (ctx, state) {
              final cubit = SabhaCubit.get(ctx);
              return Scaffold(
                body: CustomPadding(
                  withPattern: true,
                  widget: state is SabhaStateLoadingState ? const CustomLoading(fullScreen: true,):
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomAppBar(text: LocaleKeys.remembranceList.tr()),
                        SizedBox(height: height()*0.03,),
                        ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: height()*0.02),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(vertical: width()*0.025,horizontal: width()*0.02),
                                    child: Text(
                                    cubit.allZekrModel!.data![index].content.toString(),
                                     style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t16,fontFamily: "Amiri"),
                                    ),
                                  ),
                                ),
                                cubit.allZekrModel!.data![index].user == "personal" ?
                                PopupMenuButton(
                                  icon: SvgPicture.asset(AppImages.list),
                                  onSelected: (v){
                                    cubit.newZekrCtr.text=cubit.allZekrModel!.data![index].content.toString();
                                    v == '1'?
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (_) =>BlocProvider.value(value: context.read<SabhaCubit>(),
                                            child: AddZekr(ctx: ctx, onTap: (){
                                              cubit.editZekr(id: cubit.allZekrModel!.data![index].id.toString());
                                            },)),
                                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(35)))):
                                    cubit.deleteZekr(id: cubit.allZekrModel!.data![index].id.toString());
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return List.generate(cubit.popUpList.length, (index) =>
                                       PopupMenuItem(
                                        value: cubit.popUpList[index]['id'].toString(),
                                        child: Row(
                                          children: [
                                            Text(cubit.popUpList[index]['name'].toString(),
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                color:index==0?AppColors.orangeCol:AppColors.redCol ),
                                            ),
                                            const Spacer(),
                                            SvgPicture.asset(cubit.popUpList[index]['image'])
                                          ],
                                        ),
                                    ));
                                  },
                                ):const SizedBox.shrink(),
                              ],
                            ),
                            separatorBuilder: (context, index) =>  Divider(color: AppColors.grayColor2.withOpacity(0.2),),
                            itemCount: cubit.allZekrModel!.data!.length),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
