import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/screens/part_details/view/part_details_screen.dart';
import 'package:zad/screens/quraan/controller/quraan_cubit.dart';
import 'package:zad/screens/quraan/view/widgets/quraan_item.dart';

class PartsBody extends StatelessWidget {
  const PartsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuraanCubit,QuraanStates>(
      builder: (context,state) {
        final cubit = BlocProvider.of<QuraanCubit>(context);
        return Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => QuraanItem(
                  type: QuraanItemType.parts,
                  num: cubit.parts[index]["id"].toString(),
                  onTap: () {
                    navigateTo( widget: PartDetailsScreen(id: cubit.parts[index]["id"],isPart: true,continueReading: false,scrollPos: 0,));
                  },
                  title: cubit.parts[index]["name"],),
              separatorBuilder: (context, index) => SizedBox(
                    height: height() * 0.02,
                  ),
              itemCount: cubit.parts.length),
        );
      }
    );
  }
}
