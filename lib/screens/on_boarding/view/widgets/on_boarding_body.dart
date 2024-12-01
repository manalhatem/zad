import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/size.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../controller/on_boarding_cubit.dart';
import 'custom_indicator.dart';
import 'custom_on_boarding_button.dart';
import 'custom_page_view.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (cubitContext) => OnBoardingCubit()..getOnBoarding(),
      child: BlocBuilder<OnBoardingCubit, BaseStates>(
        builder: (context, state) {
          final cubit = OnBoardingCubit.get(context);
          return Scaffold(
            body:
            state is BaseStatesLoadingState ? const CustomLoading(fullScreen: true):
            state is BaseStatesErrorState?
            Column(
              children: [
                const Spacer(),
                Center(
                  child: CustomShowMessage(
                    title: state.msg,
                    onPressed: () {
                      cubit.getOnBoarding();
                    },
                  ),
                ),
                const Spacer(),
              ],
            ):
            Column(
              children: [
                const CustomPageView(),
                SizedBox(height: height()*0.05),
                CustomIndicator(length: cubit.onBoardingModel!.data!.length, currentIndex: cubit.index,),
                SizedBox(height: height()*0.05),
                state is FajrLoadingState?
                SizedBox(height: height()*0.07):
                const CustomOnBoardingButton()
              ],
            ),
          );
        },
      ),
    );
  }
}
