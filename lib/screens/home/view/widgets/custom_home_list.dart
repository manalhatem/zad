import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/custom_toast.dart';
import 'package:zad/generated/locale_keys.g.dart';
import 'package:zad/screens/home/controller/home_cubit.dart';
import 'package:zad/screens/prayer_time/views/prayer_time_view.dart';
import '../../../../core/local/app_cached.dart';
import '../../../../core/widgets/cant_change_lang_dialog.dart';

class CustomHomeList extends StatefulWidget {
  const CustomHomeList({super.key});

  @override
  State<CustomHomeList> createState() => _CustomHomeListState();
}

class _CustomHomeListState extends State<CustomHomeList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<HomeCubit>(context);
        return Container(
          margin: EdgeInsets.symmetric(vertical: height()*0.02),
            padding: EdgeInsets.symmetric(
                horizontal: width() * 0.04,
                vertical: height() * 0.02),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.containerbgImg),
                  fit: BoxFit.fill),
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index) =>InkWell(
                onTap: (){
                  index==2&&CacheHelper.getData(key: AppCached.enabledLocation)==false?
                  showToast(text: LocaleKeys.mustEnableLocation.tr(), state: ToastStates.error):
                      context.locale.languageCode=="en" &&(index==0||index==1)?
                      showDialog(
                        context: context,
                        builder: (context) => const CantChangeLangDialog(),
                      ):
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) =>index==2? PrayerTimeScreen(currentIndex: cubit.currentIndex): cubit.widgets[index],
                    ),
                  ).then((value) => setState(() {}));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: AppRadius.r34,
                      backgroundColor: AppColors.greenColor.withOpacity(.1),
                      child: SvgPicture.asset(
                        cubit.homeList[index]["img"],
                      ),
                    ),
                    Text(
                      cubit.homeList[index]["title"],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
