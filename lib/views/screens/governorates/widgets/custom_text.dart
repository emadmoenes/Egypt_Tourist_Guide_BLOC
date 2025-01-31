import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      this.fontWeight = FontWeight.normal,
      required this.text,
      required this.fontSize,
      });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: AppColors.white,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }
}
