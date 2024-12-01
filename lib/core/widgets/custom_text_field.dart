import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/size.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;  final Widget? suffixIcon;
  final TextInputType type;
  final Function(String)?onChanged;
  final bool? readOnly;
  final int? maxLines;
 final TextStyle? style;
  const CustomTextField({super.key, this.controller, this.hintText, this.suffixIcon, this.onChanged, this.readOnly=false, this.maxLines, this.style, required this.type});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: width()*0.03),
      child: TextField(
        textAlign: TextAlign.start,
        readOnly:readOnly! ,
        onChanged: onChanged,
        cursorColor: AppColors.greenColor,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        controller: controller,
        cursorHeight: 20,
        maxLines: maxLines,
        style:style ?? Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: height() * 0.015,
              horizontal: width() * 0.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              borderSide:  BorderSide(color: Theme.of(context).dividerColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              borderSide:  BorderSide(color: Theme.of(context).dividerColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              borderSide:  BorderSide(color: Theme.of(context).dividerColor)),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.grayColor, fontSize: AppFonts.t10),
          suffixIcon: suffixIcon,
        ),
        keyboardType: type,
        showCursor: true,
        // keyboardType: widget.type,
      ),
    );
  }
}
