import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/views/home/widgets/suggested_places_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../data.dart';
import '../../widgets/error_widget.dart';

class SuggestedPlacesSection extends StatelessWidget {
  const SuggestedPlacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(builder: (context, state) {
      if (state is PlacesLoaded) {
        if (state.places.isEmpty) {
          return Center(
            child: Text('no_data'.tr()),
          );
        }
      } else if (state is PlacesError) {
        return AppErrorWidget();
      }
      return Skeletonizer(
        enabled: state is PlacesLoading,
        child: SuggestedPlacesGrid(
          suggestedPlaces:
              context.locale.toString() == 'ar' ? ARABICPLACES : PLACES,
        ),
      );
    });
  }
}
