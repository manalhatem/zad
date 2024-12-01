import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/size.dart';
import '../../controller/favourite_cubit.dart';

class CustomToggleFav extends StatelessWidget {
  const CustomToggleFav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, BaseStates>(
        builder: (context, state) {
      FavouriteCubit cubit = FavouriteCubit.get(context);
      return Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: width()*0.025),
        decoration:  BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
        child: Row(
          children: List.generate(cubit.favourites.length, (index) =>
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                  onTap: () {
                    cubit.changeColor(index);
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: width()*0.038),
                    margin: EdgeInsetsDirectional.symmetric(
                        horizontal: width()*0.02
                    ),
                    decoration:
                    cubit.currentIndex==index
                        ?
                    BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(AppRadius.r8)):
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.r8)
                    ),
                    child: Center(
                      child: Text(
                        cubit.favourites[index],
                        style: TextStyle(
                            color: cubit.currentIndex==index?
                            AppColors.whiteCol:AppColors.noActiveCol,
                            fontSize: AppFonts.t14
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ),
      );

        });
  }
}
