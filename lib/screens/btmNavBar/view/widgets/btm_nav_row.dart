import 'package:flutter/material.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/screens/btmNavBar/model/btm_nav_model.dart';
import 'package:zad/screens/btmNavBar/view/widgets/btm_nav_item.dart';

class CustomBtmNavRow extends StatelessWidget {
  final BottomNavModel firstItem;
  final BottomNavModel secItem;
  final bool? padding;

  const CustomBtmNavRow({super.key, required this.firstItem, required this.secItem , this.padding=false});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: padding==true?width()*0.02:0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBtmNavItem(model: firstItem,),
            CustomBtmNavItem(model: secItem,),
          ],
        ),
      ),
    );
  }
}
