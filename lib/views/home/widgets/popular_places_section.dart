import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:egypt_tourist_guide/views/home/widgets/popular_places_list_view.dart';
import 'package:egypt_tourist_guide/views/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PopularPlacesSection extends StatelessWidget {
  const PopularPlacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: width * 0.81 * 0.75,
      child: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
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
            child: PopularPlacesListView(
              popularPlacesList:
                  context.locale.toString() == 'ar' ? ARABICPLACES : PLACES,
            ),
          );
        },
      ),
    );
  }
}
