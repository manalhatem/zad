import 'package:flutter/material.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/size.dart';

class CustomSavedDropDown extends StatelessWidget {
  final String? dropVal;
  final List<DropdownMenuItem<String>> items;
  final Function(String?)? onChanged;
  final bool isMultiLine;
  final Widget hint;
  const CustomSavedDropDown({super.key, required this.dropVal, required this.items,required this.onChanged,required this.isMultiLine,required this.hint});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
          value: dropVal,
          isExpanded: true,
          isDense:isMultiLine?false : true,
          hint: hint,
        dropdownColor:Theme.of(context).scaffoldBackgroundColor ,
        items: items,
          icon:const Icon(Icons.keyboard_arrow_down,color: AppColors.greenColor,),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r11),
                borderSide: const BorderSide(color: AppColors.greenColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r11),
                borderSide: const BorderSide(color: AppColors.greenColor)
            ),

          ),
          onChanged: onChanged);
  }
}
