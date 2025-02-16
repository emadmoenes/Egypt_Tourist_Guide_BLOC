import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:egypt_tourist_guide/views/screens/home/widgets/suggested_places_grid.dart';
import 'package:egypt_tourist_guide/views/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../models/place_model.dart';

class SuggestedPlacesSection extends StatelessWidget {
  const SuggestedPlacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(builder: (context, state) {
      List<PlacesModel> places = PLACES;
      if (state is PlacesLoaded) {
        if (state.places.isEmpty) {
          return Center(
            child: Text('no_data'.tr()),
          );
        } else {
          places = state.places;
        }
      } else if (state is PlacesError) {
        print(state.message);
        return AppErrorWidget(errorMessage: state.message);
      }
      return Skeletonizer(
        enabled: state is PlacesLoading,
        child: SuggestedPlacesGrid(
          suggestedPlaces: places,
        ),
      );
    });
  }
}
