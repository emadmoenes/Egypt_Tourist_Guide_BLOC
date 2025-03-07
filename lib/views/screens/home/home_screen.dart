import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/controllers/theme_bloc/theme_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:egypt_tourist_guide/models/screen_model.dart';
import 'package:egypt_tourist_guide/views/screens/favorites/favorites_screen.dart';
import 'package:egypt_tourist_guide/views/screens/governorates/governorates_screen.dart';
import 'package:egypt_tourist_guide/views/screens/home/widgets/app_bottom_navigation_bar.dart';
import 'package:egypt_tourist_guide/views/screens/home/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of different screens using Screen Model
    List<ScreenModel> screens = [
      const ScreenModel(title: 'app_title', body: HomeScreenBody()),
      const ScreenModel(title: 'governorates', body: GovernoratesScreen()),
      const ScreenModel(title: 'favorites_title', body: FavoritesScreen()),
      ScreenModel(title: 'settings_title', body: ProfileScreen()),
    ];

    return Scaffold(
      bottomNavigationBar: const AppBottomNavigationBar(),
      appBar: AppBar(
          title: BlocBuilder<PlacesBloc, PlacesState>(
            builder: (context, state) {
              final PlacesBloc placesBloc = context.read<PlacesBloc>();
              return Text(
                screens[placesBloc.currentPageIndex].title.tr(),
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
                        ? const Locale('ar')
                        : const Locale('en');
                    context.setLocale(newLocale);
                  },
                );
              },
            ),
          ]),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 11),
        child: BlocBuilder<PlacesBloc, PlacesState>(
          builder: (context, state) {
            final placesBloc = context.read<PlacesBloc>();
            return screens[placesBloc.currentPageIndex].body;
          },
        ),
      ),
    );
  }
}
