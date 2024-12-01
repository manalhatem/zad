import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/size.dart';

class DropDownBorderItem extends StatelessWidget {
  final String? hint;
  final dynamic dropDownValue ;
  final List<DropdownMenuItem<String>> items ;
  final void Function(String?) onChanged  ;
  final Widget? icon;
  final Color? bordCol;
  const DropDownBorderItem({super.key, required this.hint,this.dropDownValue, required this.onChanged, required this.items, this.icon, this.bordCol});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      onChanged: onChanged,
      value:dropDownValue,
      isExpanded: true,
      dropdownColor:Theme.of(context).scaffoldBackgroundColor ,
      style:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: height() * 0.015,
            horizontal: width() * 0.03),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            borderSide:  BorderSide(color:bordCol ?? Theme.of(context).dividerColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            borderSide:  BorderSide(color:bordCol ?? Theme.of(context).dividerColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            borderSide:  BorderSide(color:bordCol ?? Theme.of(context).dividerColor)),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.grayColor, fontSize: AppFonts.t10),
      ),
      icon:icon ?? const RotatedBox(quarterTurns: 1,
      child: Icon(Icons.arrow_back_ios_new, color: AppColors.greenColor,)),
      iconSize: 18,
      items: items,
    );
  }
}