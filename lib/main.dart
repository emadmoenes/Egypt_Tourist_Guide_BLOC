import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_bloc.dart';
import 'package:egypt_tourist_guide/controllers/theme_bloc/theme_bloc.dart';
import 'dart:developer';
import 'package:egypt_tourist_guide/controllers/places_bloc/places_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:egypt_tourist_guide/core/app_routes.dart';
import 'package:egypt_tourist_guide/core/app_strings_en.dart';
import 'package:egypt_tourist_guide/core/custom_page_routes.dart';
import 'package:egypt_tourist_guide/core/services/shared_prefs_service.dart';
import 'package:egypt_tourist_guide/views/screens/auth/login_screen.dart';
import 'package:egypt_tourist_guide/views/screens/auth/signup_screen.dart';
import 'package:egypt_tourist_guide/views/screens/governorates/governoarates_places.dart';
import 'package:egypt_tourist_guide/views/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'controllers/profile_bloc/profile_bloc.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await SharedPrefsService.init();
  String? token =
      SharedPrefsService.getStringData(key: AppStringEn.tokenKey);
  Widget startWidget = LoginScreen();
  if (token != null) {
    startWidget = HomeScreen();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MyApp(
        startPage: startWidget,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startPage});

  final Widget startPage;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale.languageCode == 'en';
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (context) => PlacesBloc()
            ..add(LoadPlacesEvent(isEnglish))
            ..add(GetFavouritePlaces(isEnglish)),
        ),
        BlocProvider(
          create: (context) => ProfileBloc()..add(LoadProfileEvent()),
        ),
        BlocProvider(
          create: (context) {
            final themeBloc = ThemeBloc();
            themeBloc.add(InitEvent());
            return themeBloc;
          },
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'merriweather',
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.lightPurple,
                ),
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: AppColors.blackColor),
                elevation: 0.8,
              ),
              dividerTheme: DividerThemeData(
                color: AppColors.lightPurple,
              ),
            ),
            darkTheme: ThemeData(
              fontFamily: 'merriweather',
              brightness: Brightness.dark,
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.deepPurpleAccent,
                ),
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: AppColors.white),
                elevation: 0.8,
              ),
              dividerTheme: DividerThemeData(
                color: AppColors.deepPurpleAccent,
              ),
            ),
            themeMode: state.themeMode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateRoute: onGenerateRoute,
            home: startPage,
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////
/*----- On Generate page routes ----*/
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  log('Navigating to: ${settings.name}');
  switch (settings.name) {
    case AppRoutes.signupRoute:
      return SlideRightRoute(child: const SignupScreen());
    case AppRoutes.loginRoute:
      return SlideRightRoute(child: const LoginScreen());
    case AppRoutes.homeRoute:
      return FadeTransitionRoute(child: const HomeScreen());
    case AppRoutes.placesRoute:
      // Extract arguments and pass them to GovernoratesPlaces
      final args = settings.arguments as Map<String, dynamic>;
      return SlideRightRoute(
        child: GovernoratesPlaces(
          governorate: args['governorate'],
          places: args['places'],
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      );
  }
}
