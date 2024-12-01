import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:zad/screens/sora_details/view/widgets/sora_details_body.dart';

class SoraDetailsScreen extends StatelessWidget {
  final int id;
  final int? continueReadingId;
  final bool continueReading;
  final double scrollPos;
  final ConnectivityResult connectivityResult;
  const SoraDetailsScreen({super.key, required this.id,   required this.continueReading,    required this.connectivityResult,   required this.scrollPos,  this.continueReadingId});

  @override
  Widget build(BuildContext context) {
    return SoraDetailsBody(id: id,continueReadingId: continueReadingId,continueReading: continueReading,scrollPos: scrollPos,connectivityResult: connectivityResult,);
  }
}
