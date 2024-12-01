import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zad/core/utils/images.dart';
import 'package:zad/generated/locale_keys.g.dart';

import '../utils/colors.dart';
import '../utils/size.dart';

class CustomDropDown extends StatelessWidget {
  final String? dropVal;
  final List<DropdownMenuItem<String>> items;
  final Function(String?)? onChanged;
  const CustomDropDown({super.key,  this.dropVal, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: dropVal,
      items: items,
      onChanged: onChanged,
      dropdownColor:Theme.of(context).scaffoldBackgroundColor ,
      hint: Text(LocaleKeys.choseVal.tr(),style: TextStyle(color: AppColors.grayColor, fontSize: AppFonts.t10),) ,
      isExpanded: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      icon: SvgPicture.asset(AppImages.dropDownIcn),
    );
  }
}
