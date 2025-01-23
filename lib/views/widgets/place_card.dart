import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/controllers/home_controller/home_cubit.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_colors.dart';

class PlaceCard extends StatelessWidget {
  final PlacesModel place;
  final bool isWide;

  final VoidCallback? onFavoriteToggled;

  const PlaceCard({
    super.key,
    required this.place,
    required this.isWide,
    this.onFavoriteToggled,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double textFactor = width / 415;
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    return InkWell(
      child: Container(
        width: isWide ? width * 0.81 : width * 0.42,
        height: isWide ? width * 0.81 * 0.75 : width * 0.42,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
                image: AssetImage(place.image), fit: BoxFit.fill)),
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: width * 0.135,
              padding: EdgeInsets.all(width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.secGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            place.name,
                            style: TextStyle(
                                fontSize: textFactor * 14,
                                color: AppColors.white,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                        ),
                        /*------- Favourite icon -------*/
                        InkWell(
                          onTap: () {
                            homeCubit.togglingFavourite(place: place,isArabic: context.locale.toString() == 'ar');
                            onFavoriteToggled?.call();
                          },
                          child: CircleAvatar(
                    
                              backgroundColor: AppColors.white,
                              maxRadius: 10,
                              child: place.isFav
                                  ? Icon(
                                      Icons.favorite_rounded,
                                      color: AppColors.favoriteIconColor,
                                      size: 10,
                                    )
                                  : Icon(
                                      Icons.favorite_outline_rounded,
                                      color: AppColors.blackColor,
                                      size: 10,
                                    )),
                    
                        )
                      ],
                    ),
                  ),
                  Text(
                    place.description,
                    style: TextStyle(
                        fontSize: textFactor * 11,
                        color: AppColors.white,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
