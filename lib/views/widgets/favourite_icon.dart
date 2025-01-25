import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:flutter/material.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key,
    required this.isFav,
  });

  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
      color: isFav ? AppColors.favoriteIconColor : AppColors.blackColor,
      size: 10,
    );
  }
}
