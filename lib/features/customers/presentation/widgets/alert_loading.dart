import 'package:flutter/material.dart';
import 'package:searchino/core/widgets.dart';

class AlertLoading extends StatelessWidget {
  const AlertLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: LoadingWidget(),
    );
  }
}