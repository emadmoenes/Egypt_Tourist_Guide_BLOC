import 'package:easy_localization/easy_localization.dart';
import 'package:egypt_tourist_guide/controllers/nav_bar/nav_bar_cubit.dart';
import 'package:egypt_tourist_guide/controllers/nav_bar/nav_bar_states.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarStates>(
      builder: (context, state) {
        NavBarCubit navBarCubit = context.read<NavBarCubit>();
        return BottomNavigationBar(
          backgroundColor: AppColors.purple,
          onTap: (int pageIndex) {
            navBarCubit.changeIndex(pageIndex);
          },
          currentIndex: navBarCubit.currentNavBarIndex,
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
