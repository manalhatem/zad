import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/utils/azan_cubit.dart';
import 'package:zad/core/utils/colors.dart';
import '../../../../core/utils/base_state.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../controller/notification_cubit.dart';

class SuggestNotification extends StatelessWidget {
  const SuggestNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzanCubit, BaseStates>(
        builder: (context, state) {
          final cubit = AzanCubit.get(context);
          return Container(
            padding: EdgeInsets.symmetric(vertical: width()*0.02),
            margin: EdgeInsetsDirectional.symmetric(vertical:width()*0.06),
            decoration: BoxDecoration(
                border: Border.all(color:Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(AppRadius.r8)
            ),
            child:
            Column(
                children: List.generate(cubit.notificationStaticModel!.data!.length, (index) => Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: width()*0.04,vertical:width()*0.02 ),
                      child: Row(
                        children: [
                          Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Text(cubit.notificationStaticModel!.data![index].title.toString(), style: Theme.of(context).textTheme.titleMedium),
                              Text("${cubit.notificationStaticModel!.data![index].type}  ${cubit.notificationStaticModel!.data![index].time}", style: TextStyle(fontSize: AppFonts.t10, color: AppColors.greenColor)),

                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: (){cubit.changeStatus(id: cubit.notificationStaticModel!.data![index].id.toString(), isStatic: true, index: index);},
                              child: SvgPicture.asset(cubit.notificationStaticModel!.data![index].isActive == true? AppImages.active:AppImages.notActive))
                        ],
                      ),
                    ),
                    cubit.notificationStaticModel!.data!.length -1== index? const SizedBox.shrink():
                    Divider(color: Theme.of(context).dividerColor),

                  ],
                ))
            ),

          );

        });
  }
}
