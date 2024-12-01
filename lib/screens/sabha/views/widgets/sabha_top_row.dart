import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_border_dropdown.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controller/sabha_cubit.dart';
import '../../controller/sabhq_state.dart';
import 'add_zekr.dart';

class SabhaTopRow extends StatelessWidget {
  final BuildContext ctx;

  const SabhaTopRow({super.key, required this.ctx});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SabhaCubit, SabhaState>(builder: (context, state) {
      final cubit = SabhaCubit.get(context);
      return Row(
        children: [
          Expanded(
            child: DropDownBorderItem(
              bordCol: AppColors.noActiveCol,
              icon: cubit.selectZekr == true
                  ? const SizedBox.shrink()
                  : const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(Icons.arrow_back_ios_new,
                          color: AppColors.greenColor)),
              items: List.generate(
                cubit.allZekrModel!.data!.length,
                (index) {
                  if (cubit.allZekrModel!.data![index].id.toString() ==
                      cubit.chooseAzkar) {
                    return DropdownMenuItem<String>(
                      onTap: () {
                        cubit.changeZekr(
                            cubit.allZekrModel!.data![index].content.toString(),
                            cubit.allZekrModel!.data![index].user.toString());
                        cubit.zeroCounter();
                        cubit.allZekrModel!.data![index].user == "public"
                            ? cubit.getFadlElZekr(
                                id: cubit.allZekrModel!.data![index].id
                                    .toString())
                            : null;
                      },
                      value: cubit.allZekrModel!.data![index].id.toString(),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width() * 0.56,
                            child: Text(
                              cubit.allZekrModel!.data![index].content
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                  color: AppColors.orangeCol,
                                  fontSize: AppFonts.t14,
                                  fontFamily: "Amiri"),
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(AppImages.check),
                        ],
                      ),
                    );
                  } else {
                    return DropdownMenuItem<String>(
                      onTap: () {
                        cubit.changeZekr(
                            cubit.allZekrModel!.data![index].content.toString(),
                            cubit.allZekrModel!.data![index].user.toString());
                        cubit.zeroCounter();
                        cubit.allZekrModel!.data![index].user == "public"
                            ? cubit.getFadlElZekr(
                                id: cubit.allZekrModel!.data![index].id
                                    .toString())
                            : null;
                      },
                      value: cubit.allZekrModel!.data![index].id.toString(),
                      child: SizedBox(
                        width: width() * 0.56,
                        child: Text(
                          cubit.allZekrModel!.data![index].content.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                              color: AppColors.grayColor,
                              fontSize: AppFonts.t14),
                        ),
                      ),
                    );
                  }
                },
              ),
              onChanged: (value) {
                cubit.changeAzkar(value);
              },
              dropDownValue: cubit.chooseAzkar,
              hint: LocaleKeys.chooseZekr.tr(),
            ),
          ),
          SizedBox(width: width() * 0.015),
          CustomBtn(
              title: LocaleKeys.addNewZekr.tr(),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => BlocProvider.value(
                        value: context.read<SabhaCubit>(),
                        child: AddZekr(ctx: ctx)),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(35))));
              },
              type: BtnType.selected)
        ],
      );
    });
  }
}
