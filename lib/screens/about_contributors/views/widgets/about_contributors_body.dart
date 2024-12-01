import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/about_contributors_cubit.dart';
import 'about_contributors_item.dart';

class AboutContributorsBody extends StatelessWidget {
  const AboutContributorsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => AboutContributorsCubit()..getContributors(),
        child: BlocBuilder<AboutContributorsCubit, BaseStates>(
        builder: (context, state) {
         final cubit = AboutContributorsCubit.get(context);
         return Scaffold(
          body: CustomPadding(
          withPattern: true,
          widget:Column(
          children: [
           CustomAppBar(text: LocaleKeys.aboutShareholders.tr()),
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
                        cubit.getContributors();
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ):
            Expanded(
              child: ListView.separated(itemBuilder: (context, index){
                return  AboutContributorsItem(img: cubit.contributorsModel!.data![index].image!,
                    name:cubit.contributorsModel!.data![index].name.toString(),subTitle: cubit.contributorsModel!.data![index].role.toString());
              }, separatorBuilder: (context, index){
                return  SizedBox(height:width()*0.035);
              }, itemCount: cubit.contributorsModel!.data!.length),
            )


          ])));}));
  }
}
