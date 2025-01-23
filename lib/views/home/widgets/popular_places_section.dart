import 'package:egypt_tourist_guide/controllers/home_controller/home_cubit.dart';
import 'package:egypt_tourist_guide/controllers/home_controller/home_states.dart';
import 'package:egypt_tourist_guide/data.dart';
import 'package:egypt_tourist_guide/views/home/widgets/popular_places_list_view.dart';
import 'package:egypt_tourist_guide/views/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class PopularPlacesSection extends StatelessWidget {
  const PopularPlacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: width * 0.81 * 0.75,
      child: BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
        if (state is HomeSuccessState) {
          if (state.data.isEmpty) {
            return Center(
              child: Text('no_data'.tr()),
            );
          } else {
            return PopularPlacesListView(popularPlacesList: context.locale.toString() == 'ar' ? ARABICPLACES:PLACES);
          }
        } else if (state is HomeErrorState) {
          return AppErrorWidget();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
