import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/base_state.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/btmNavBar/controller/nav_bar_cubit.dart';
import 'package:zad/screens/btmNavBar/model/btm_nav_model.dart';
import 'package:zad/screens/btmNavBar/view/widgets/btm_nav_row.dart';

class CustomBtmNavBar extends StatelessWidget {
  const CustomBtmNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, BaseStates>(
          builder: (context, state) {
            final cubit = BlocProvider.of<NavBarCubit>(context);
            return Scaffold(
            extendBody: true,
            body: cubit.pages[cubit.currentIndex],
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: SvgPicture.asset(AppImages.floatBtn),
            bottomNavigationBar:  BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 5,
              color: Theme.of(context).disabledColor,
              padding: EdgeInsets.symmetric(horizontal: width()*0.05),
              child: Row(
                children: [
                  CustomBtmNavRow(
                    firstItem: BottomNavModel(
                        title: LocaleKeys.home_.tr(),
                        image: AppImages.homeIcn,
                        colored: cubit.currentIndex==0?true : false,
                        onTap: (){cubit.changeIndex(index: 0);}),
                    secItem: BottomNavModel(title: LocaleKeys.saved_.tr(), image: AppImages.savedIcn, colored: cubit.currentIndex==1?true : false,onTap: (){cubit.changeIndex(index: 1);}),
                  ),
                  SizedBox(width: width()*0.2),
                  CustomBtmNavRow(
                    padding: true,
                    firstItem: BottomNavModel(title: LocaleKeys.favourite_.tr(), image: AppImages.favIcn, colored: cubit.currentIndex==2?true : false,onTap: (){cubit.changeIndex(index: 2);}),
                    secItem: BottomNavModel(title: LocaleKeys.settings_.tr(), image: AppImages.settingIcn, colored: cubit.currentIndex==3?true : false,onTap: (){cubit.changeIndex(index: 3);}),),
                ],
              ),
            ),
          );
        }
      ),
    );
  }}
