import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/views/home/widgets/recommended_places_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/home_controller/home_cubit.dart';
import '../../controllers/home_controller/home_states.dart';
import '../../core/app_colors.dart';
import '../../models/governorate_model.dart';
import '../../models/place_model.dart';
import '../home/widgets/home_section_title.dart';

class GovernoratesPlaces extends StatefulWidget {
  final GovernorateModel governorate;
  final List<PlacesModel> places;

  const GovernoratesPlaces({
    super.key,
    required this.governorate,
    required this.places,
  });

  @override
  State<GovernoratesPlaces> createState() => _GovernoratesPlacesState();
}

class _GovernoratesPlacesState extends State<GovernoratesPlaces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.governorate.name} '),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "hero-${widget.governorate.id}",
            child: Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(widget.governorate.image),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.governorate.name,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.governorate.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          HomeSectionTitle(text: "places".tr()),
          BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              return RecommendedPlacesGrid(
                recommendedPlaces: widget.places,
                isWide: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
