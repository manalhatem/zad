import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/size.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_padding.dart';

class ShowVideoInApp extends StatefulWidget {
  final String path;
  final String title;
  const ShowVideoInApp({super.key, required this.path, required this.title});

  @override
  State<ShowVideoInApp> createState() => _ShowVideoInAppState();
}

class _ShowVideoInAppState extends State<ShowVideoInApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path))
        ..initialize().then((_) {
          setState(() {});
        });
  }
  @override
  void dispose() {
    super.dispose();
      _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:CustomPadding(
        widget:Column(
        children: [
          CustomAppBar(text: widget.title),
          _controller.value.isInitialized ?
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, VideoPlayerValue value, child) {
              return Column(
              children: [
                SizedBox(
                  height: height()*0.5,
                  child: VideoPlayer(_controller),
                ),
                Slider(
                    value:value.position.inSeconds.toDouble(),
                    min: 0.0,
                    max: _controller.value.duration.inSeconds.toDouble(),
                    onChanged: (c){
                      _controller.seekTo(Duration(seconds: c.toInt()));
                    },
                activeColor: AppColors.orangeCol,
                ),
                InkWell(
                    onTap:(){
                      setState(() {
                        _controller.value.isPlaying ?
                        _controller.pause():_controller.play();
                      });
                    },
                    child: SvgPicture.asset(_controller.value.isPlaying ? AppImages.stopVideo : AppImages.video,
                        width: width() * 0.13)),
              ],
            );},
          ):const CustomLoading(fullScreen: true),

        ]))
    );
  }
}
