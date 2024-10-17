import 'package:flutter/material.dart';
import 'package:to_do_app_advanced/core/utils/app_colors.dart';

class CustomBotton extends StatelessWidget {
  CustomBotton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = AppColors.primary});

  final String text;
  final VoidCallback onPressed;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: MaterialStateProperty.all(backgroundColor)),
      child: Text(text),
    );
  }
}
