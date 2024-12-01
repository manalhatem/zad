import 'package:flutter/material.dart';
import 'widgets/multi_media_details_body.dart';


class MultiMediaDetailsScreen extends StatelessWidget {
  final int id;
  final String name;
  const MultiMediaDetailsScreen({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return  MultiMediaDetailsBody(id: id, name: name);
  }
}
