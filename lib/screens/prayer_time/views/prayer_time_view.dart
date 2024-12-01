import 'package:flutter/material.dart';
import 'widgets/prayer_time_body.dart';


class PrayerTimeScreen extends StatelessWidget {
final int currentIndex;

  const PrayerTimeScreen({super.key, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    return  PrayerTimeBody(currentIndex: currentIndex,);
  }
}
