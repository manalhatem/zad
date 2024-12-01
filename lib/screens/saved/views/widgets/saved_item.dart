import 'package:flutter/material.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/screens/saved/views/widgets/saved_row.dart';

class SavedItem extends StatelessWidget {
  final bool isLast;
  final String faselName,faselSubTitle,img;
  final Function() onTap;

  const SavedItem({super.key, required this.isLast, required this.faselName, required this.faselSubTitle, required this.img, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SavedRow(
          title: faselName,
          subTitle:faselSubTitle,
          img: img,
          onTap: onTap,
        ),
        if(isLast==false)
        Padding(
          padding:EdgeInsets.symmetric(vertical: width()*0.02),
          child: Divider(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ],
    );
  }
}
