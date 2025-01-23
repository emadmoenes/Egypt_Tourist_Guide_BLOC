import 'package:egypt_tourist_guide/controllers/home_controller/home_cubit.dart';
import 'package:egypt_tourist_guide/core/app_routes.dart';
import 'package:egypt_tourist_guide/views/auth/login_screen.dart';
import 'package:egypt_tourist_guide/views/auth/signup_screen.dart';
import 'package:egypt_tourist_guide/views/governorates/governoarates_places.dart';
import 'package:egypt_tourist_guide/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/custom_page_routes.dart'; // Ensure this import is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..fetchHomeData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'merriweather'),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: (settings) {
          print('Navigating to: ${settings.name}'); // Debugging
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
        },
        home: const SignupScreen(),
      ),
    );
  }
}