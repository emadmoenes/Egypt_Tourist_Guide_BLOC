import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/models/screen_model.dart';
import 'package:egypt_tourist_guide/views/favorites/favorites_screen.dart';
import 'package:egypt_tourist_guide/views/governorates/governorates_screen.dart';
import 'package:egypt_tourist_guide/views/home/widgets/app_bottom_navigation_bar.dart';
import 'package:egypt_tourist_guide/views/home/widgets/home_screen_body.dart';
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
      ScreenModel(title: 'app_title'.tr(), body: HomeScreenBody()),
      ScreenModel(title: 'governorates'.tr(), body: GovernoratesScreen()),
      ScreenModel(title: 'favorites_title'.tr(), body: FavoritesScreen()),
      ScreenModel(title: 'settings_title'.tr(), body: ProfileScreen()),
    ];

    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(),
      appBar: AppBar(
          elevation: 0.5,
          title: BlocBuilder<PlacesBloc, PlacesState>(
            builder: (context, state) {
              final placesBloc = context.read<PlacesBloc>();
              return Text(
                screens[placesBloc.currentPageIndex].title,
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.language, size: 30),
              onPressed: () {
                // Toggle between English and Arabic
                final newLocale = context.locale.languageCode == 'en'
                    ? Locale('ar')
                    : Locale('en');
                context.setLocale(newLocale);
              },
            ),
          ]),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 11),
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
