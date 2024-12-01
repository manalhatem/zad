import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/alward_alsarie/views/widgets/player_section.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../controller/alward_alsarie_cubit.dart';
import '../../../add_alwerd/view/add_alward.dart';
import 'alward_item.dart';

class AlwardAlsarieBody extends StatelessWidget {
  const AlwardAlsarieBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlwardAlsarieCubit, AlwerdAlsarieStates>(
          builder: (context, state) {
        final cubit = BlocProvider.of<AlwardAlsarieCubit>(context);
        return state is LoadingAlwerdAlsarieState
            ? const CustomLoading(fullScreen: true)
            : state is ErrorAlwerdAlsarieState
                ? Column(
                    children: [
                      const Spacer(),
                      Center(
                        child: CustomShowMessage(
                          title: state.msg,
                          onPressed: () => cubit.fetchTracks(),
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                : CustomPadding(
                    withPattern: true,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(text: LocaleKeys.choseAndListen.tr()),
                        CustomDrawer(
                            onTap: () {
                              navigateTo(
                                  widget: BlocProvider.value(
                                value: context.read<AlwardAlsarieCubit>(),
                                child: const AddAlward(
                                  isEdit: false,
                                ),
                              ));
                            },
                            fromHome: false),
                        if (cubit.tracksModel!.data!.isNotEmpty)
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: width() * 0.03,
                                vertical: width() * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.lists.tr(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                    "${cubit.tracksModel!.data!.length.toString()} ${LocaleKeys.listts.tr()}",
                                    style: TextStyle(
                                        color: AppColors.orangeCol,
                                        fontSize: AppFonts.t12)),
                              ],
                            ),
                          ),
                        if (cubit.tracksModel!.data!.isNotEmpty)
                          Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return AlwardItem(
                                      id: cubit.tracksModel!.data![index].id!,
                                      idx: index,
                                      onTapEdit: () {
                                        navigateTo(
                                            widget: BlocProvider.value(
                                          value: context
                                              .read<AlwardAlsarieCubit>(),
                                          child: AddAlward(
                                            id: cubit
                                                .tracksModel!.data![index].id!,
                                            isEdit: true,
                                          ),
                                        ));
                                      },
                                      onAdd: () {
                                        navigateTo(
                                            widget: BlocProvider.value(
                                          value: context
                                              .read<AlwardAlsarieCubit>(),
                                          child: AddAlward(
                                            id: cubit
                                                .tracksModel!.data![index].id!,
                                            isEdit: false,
                                          ),
                                        ));
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: height() * 0.02,
                                      ),
                                  itemCount: cubit.tracksModel!.data!.length)),
                        if (cubit.tracksModel!.data!.isNotEmpty)
                          const PlayerSection()
                      ],
                    ),
                  );
      }),
    );
  }
}
