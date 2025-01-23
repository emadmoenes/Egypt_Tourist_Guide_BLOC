import 'package:egypt_tourist_guide/models/governorate_model.dart';
import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import 'custom_text.dart';

class GovernorateCard extends StatelessWidget {
  const GovernorateCard({
    super.key,
    required this.governorate,
    this.onTap,
    required this.height,
    required this.width,
  });

  final GovernorateModel governorate;
  final double height;
  final double width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double baseContainerHeight = height * 0.5;
    double textFactor = height / 500;
    return InkWell(
      onTap: onTap,
      // Go to governorate places
      child: Card(
        child: Hero(
          tag: "hero-${governorate.id}",
          child: Container(
            width: width * 0.81,
            height: baseContainerHeight,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.containerColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(2, 6),
                ),
              ],
              image: DecorationImage(
                  image: AssetImage(governorate.image), fit: BoxFit.fill),
            ),
            alignment: Alignment.bottomCenter,
            child: GreyContainer(
                baseContainerHeight: baseContainerHeight,
                governorate: governorate,
                textFactor: textFactor,
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////
class GreyContainer extends StatelessWidget {
  const GreyContainer({
    super.key,
    required this.baseContainerHeight,
    required this.governorate,
    required this.textFactor,
  });

  final double baseContainerHeight;
  final GovernorateModel governorate;
  final double textFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: baseContainerHeight * 0.22,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10)
        ),
        color: AppColors.greyColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: governorate.name,
            fontSize: textFactor * 14,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            text: governorate.description,
            fontSize: textFactor * 11,
          ),
        ],
      ),
    );
  }
}
