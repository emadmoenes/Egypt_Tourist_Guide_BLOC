import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        final placesBloc = context.read<PlacesBloc>();
        return BottomNavigationBar(
          backgroundColor: AppColors.purple,
          onTap: (int pageIndex) {
            placesBloc.add(ChangeBottomNavigationIndexEvent(pageIndex));
          },
          currentIndex: placesBloc.currentPageIndex,
          selectedItemColor: AppColors.purple,
          unselectedItemColor: AppColors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'governorates'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              label: 'liked'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'settings'.tr(),
            ),
          ],
        );
      },
    );
  }
}
