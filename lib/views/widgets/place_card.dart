import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_colors.dart';

class PlaceCard extends StatelessWidget {
  final PlacesModel place;
  final bool isWide;

  //final VoidCallback? onFavoriteToggled;

  const PlaceCard({
    super.key,
    required this.place,
    required this.isWide,
    //this.onFavoriteToggled,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double textFactor = width / 415;
    // HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    final placesBloc = context.read<PlacesBloc>();
    var isFav = place.isFav;
    return InkWell(
      child: Container(
        width: isWide ? width * 0.81 : width * 0.25,
        height: isWide ? width * 0.81 * 0.75 : width * 0.46,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: AppColors.containerColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.greyColor.withValues(alpha: 0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(2, 6),
              ),
            ],
            image: DecorationImage(
                image: AssetImage(place.image), fit: BoxFit.fill)),
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: isWide ? width * 0.135 : width * 0.13,
          padding: EdgeInsets.all(width * 0.02),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            color: AppColors.secGrey,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        place.name,
                        style: TextStyle(
                          fontSize: isWide? textFactor * 16 : textFactor * 14,
                          color: AppColors.white,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    /*------- Favourite icon -------*/
                    InkWell(
                      onTap: () {
                        placesBloc.add(
                          ToggleFavouriteEvent(
                            place,
                            context.locale.toString() == 'ar',
                          ),
                        );
                      },
                      child: BlocConsumer<PlacesBloc, PlacesState>(
                        listener: (context, state) {
                          if (state is FavoriteToggledState) {
                            isFav = state.place.isFav;
                          }
                        },
                        builder: (context, state) {
                          return CircleAvatar(
                            backgroundColor: AppColors.white,
                            maxRadius: isWide ? 10 : 8,
                            child: isFav
                                ? Icon(
                                    Icons.favorite_rounded,
                                    color: AppColors.favoriteIconColor,
                                    size: 10,
                                  )
                                : Icon(
                                    Icons.favorite_outline_rounded,
                                    color: AppColors.blackColor,
                                    size: 10,
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Text(
                place.description,
                style: TextStyle(
                  fontSize: isWide ? textFactor * 11.2 : textFactor * 10,
                  color: AppColors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
