import 'package:flutter/material.dart';
import 'package:searchino/core/app_theme.dart';

class SignInAccountWidget extends StatelessWidget {
  final String image;
  final void Function() onAction;
  const SignInAccountWidget(
      {super.key, required this.image, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      elevation: 5.0,
      shadowColor: primaryColor,
      child: InkWell(
          onTap: onAction,
          child: CircleAvatar(
            radius: 35.0,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/$image'),
          )),
    );
  }
}
