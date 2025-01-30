import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:egypt_tourist_guide/models/governorate_model.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:egypt_tourist_guide/views/widgets/favourite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_colors.dart';

class PlaceCard extends StatelessWidget {
  final PlacesModel place;
  final bool isWide;

  const PlaceCard({
    super.key,
    required this.place,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double textFactor = width / 415;
    List<GovernorateModel> governorateList =
        context.locale.toString() == 'ar' ? ARABICGOVERNORATES : GOVERNERATES;
    GovernorateModel placeGovernorate = governorateList
        .firstWhere((element) => element.id == place.governorateId);
    final placesBloc = context.read<PlacesBloc>();
    double bigContainerHeight = isWide ? width * 0.81 * 0.75 : width * 0.48;
    bool? isFav = place.isFav;
    return InkWell(
      child: Container(
        width: isWide ? width * 0.81 : width * 0.25,
        height: bigContainerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.containerColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(2, 6),
            ),
          ],
          image:
              DecorationImage(image: AssetImage(place.image), fit: BoxFit.fill),
        ),
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: bigContainerHeight * 0.29,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // place name and fav icon
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // place name
                    Expanded(
                      child: Text(
                        place.name,
                        style: TextStyle(
                          fontSize:
                              isWide ? textFactor * 16 : textFactor * 12.5,
                          color: AppColors.white,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
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
                            isFav = state.place?.isFav;
                          }
                        },
                        builder: (context, state) {
                          return CircleAvatar(
                            backgroundColor: AppColors.white,
                            maxRadius: isWide ? 10 : 8,
                            child: FavouriteIcon(
                              isFav: isFav ?? false,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 2),
              // Governorate name of the place
              Text(
                placeGovernorate.name,
                style: TextStyle(
                  fontSize: isWide ? textFactor * 11.2 : textFactor * 9,
                  color: AppColors.white,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // place description
              Text(
                place.description,
                style: TextStyle(
                  fontSize: isWide ? textFactor * 11.2 : textFactor * 9,
                  color: AppColors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
