import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/size.dart';

class CountDownTime extends StatefulWidget {
  final int hour;
  final int minute;
  final int second;

  const CountDownTime({super.key, required this.hour, required this.minute, required this.second});

  @override
  State<CountDownTime> createState() => _CountDownTimeState();
}


class _CountDownTimeState extends State<CountDownTime> with SingleTickerProviderStateMixin {
  late final CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin:  Duration(hours:widget.hour,minutes: widget.minute, seconds: widget.second),
      end: const Duration(),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds
  );
  @override
  void initState() {
    super.initState();
    _controller.start();
  }
  @override
  void dispose() {
    _controller.finish();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomTimer(
        controller: _controller,
        builder: (state, time) {
          return Text(
              "${time.hours}:${time.minutes}:${time.seconds}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: AppFonts.t14)
          );
        }
    );
  }
}
