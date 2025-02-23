import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/models/place_model.dart';
import 'package:egypt_tourist_guide/views/screens/home/widgets/popular_places_list_view.dart';
import 'package:egypt_tourist_guide/views/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../data.dart';

class PopularPlacesSection extends StatelessWidget {
  const PopularPlacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: width * 0.81 * 0.75,
      child: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
          final placesBloc = PlacesBloc.get(context);
          List<PlacesModel> places = placesBloc.placesV;

          if (state is PlacesLoaded) {
            if (state.places.isEmpty) {
              return Center(
                child: Text('no_data'.tr()),
              );
            } else {
              places = state.places;
            }
          }
          if (state is FavouritePlacesSuccess) {
            places = placesBloc.placesV;
          } else if (state is PlacesError) {
            return AppErrorWidget(
              errorMessage: state.message,
            );
          }
          return Skeletonizer(
            enabled: state is PlacesLoading,
            child: PopularPlacesListView(
              popularPlacesList: places.isEmpty ? PLACES : places,
            ),
          );
        },
      ),
    );
  }
}
