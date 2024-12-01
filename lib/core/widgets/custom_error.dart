import 'package:flutter/material.dart';
import 'package:zad/core/widgets/custom_error_widget.dart';

class CustomError extends StatelessWidget {
  final String msg;
  final Function() onTap;

  const CustomError({super.key, required this.msg, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: CustomShowMessage(
              title: msg,
              onPressed: onTap,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
