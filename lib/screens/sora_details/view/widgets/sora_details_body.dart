import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zad/core/local/app_cached.dart';
import 'package:zad/core/local/cache_helper.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/screens/sora_details/controller/sora_details_cubit.dart';
import 'package:zad/screens/sora_details/view/widgets/first_layer.dart';
import 'package:zad/screens/sora_details/view/widgets/second_layer.dart';
import '../../../../core/widgets/custom_error_widget.dart';

class SoraDetailsBody extends StatefulWidget {
  final int id;
  final int? continueReadingId;
  final bool continueReading;
  final double scrollPos;
  final ConnectivityResult connectivityResult ;
  const SoraDetailsBody({super.key, required this.id, required this.scrollPos,required this.continueReading,required this.connectivityResult,  this.continueReadingId});

  @override
  State<SoraDetailsBody> createState() => _SoraDetailsBodyState();
}

class _SoraDetailsBodyState extends State<SoraDetailsBody> {
  @override
  void initState() {
    BlocProvider.of<SoraDetailsCubit>(context).fetchScreen(connResult:  widget.connectivityResult,id:widget.id,continueId:widget.continueReadingId,continueReading: widget.continueReading,scrollPos: widget.scrollPos);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoraDetailsCubit,SoraDetailsStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<SoraDetailsCubit>(context);
        return ShowCaseWidget(
            enableShowcase: CacheHelper.getData(key: AppCached.soraDetailsShowcase)==false?false:true,
            onComplete: (p0, p1) => CacheHelper.saveData(key: AppCached.soraDetailsShowcase, value: false),
            builder: (context) =>Builder(
                key: cubit.showCaseWidgets,
                builder: (context) {
                  return Scaffold(
                    body: state is SoraDetailsLoadingState?
                    const CustomLoading(fullScreen: true,):
                    state is SoraDetailsErrorState?
                    Center(
                      child: CustomShowMessage(
                        title: state.err,
                        onPressed: () => BlocProvider.of<SoraDetailsCubit>(context).fetchScreen(connResult: widget.connectivityResult,id: widget.id,continueId:widget.continueReadingId,continueReading: widget.continueReading,scrollPos: widget.scrollPos),
                      ),
                    ):
                    SafeArea(
                      child: Stack(
                        children: [
                          FirstLayer(surahId: widget.id,),
                          if (widget.connectivityResult != ConnectivityResult.wifi || widget.connectivityResult != ConnectivityResult.mobile )
                            if(cubit.isVisible)
                              SecondLayer(surahId: widget.id,)
                        ],
                      ),
                    ),
                  );
                }));

      },);
  }
}
