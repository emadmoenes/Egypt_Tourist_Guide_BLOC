import 'package:egypt_tourist_guide/controllers/nav_bar/nav_bar_cubit.dart';
import 'package:egypt_tourist_guide/controllers/nav_bar/nav_bar_states.dart';
import 'package:egypt_tourist_guide/controllers/profile_bloc/profile_bloc.dart';
import 'package:egypt_tourist_guide/controllers/theme_bloc/theme_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:egypt_tourist_guide/models/screen_model.dart';
import 'package:egypt_tourist_guide/views/screens/favorites/favorites_screen.dart';
import 'package:egypt_tourist_guide/views/screens/governorates/governorates_screen.dart';
import 'package:egypt_tourist_guide/views/screens/home/widgets/app_bottom_navigation_bar.dart';
import 'package:egypt_tourist_guide/views/screens/home/widgets/home_screen_body.dart';
import 'package:egypt_tourist_guide/views/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of different screens using Screen Model
    List<ScreenModel> screens = [
      ScreenModel(title: 'app_title'.tr(), body: HomeScreenBody()),
      ScreenModel(title: 'governorates'.tr(), body: GovernoratesScreen()),
      ScreenModel(title: 'favorites_title'.tr(), body: FavoritesScreen()),
      ScreenModel(title: 'settings_title'.tr(), body: ProfileScreen()),
    ];

    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfileEvent()),
      child: Scaffold(
        bottomNavigationBar: AppBottomNavigationBar(),
        appBar: AppBar(
            elevation: 0.5,
            title: BlocBuilder<NavBarCubit, NavBarStates>(
              builder: (context, state) {
                NavBarCubit navBarCubit = context.read<NavBarCubit>();
                return Text(
                  screens[navBarCubit.currentNavBarIndex].title,
                );
              },
            ),
            actions: [
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  ThemeBloc themeBloc = context.read<ThemeBloc>();
                  return IconButton(
                    icon: Icon(
                      Icons.language,
                      color: themeBloc.theme == 'light'
                          ? AppColors.black87Color
                          : AppColors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      // Toggle between English and Arabic
                      final newLocale = context.locale.languageCode == 'en'
                          ? Locale('ar')
                          : Locale('en');
                      context.setLocale(newLocale);
                    },
                  );
                },
              ),
            ]),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 11),
          child: BlocBuilder<NavBarCubit, NavBarStates>(
            builder: (context, state) {
              NavBarCubit navBarCubit = context.read<NavBarCubit>();
              return screens[navBarCubit.currentNavBarIndex].body;
            },
          ),
        ),
      ),
    );
  }
}
