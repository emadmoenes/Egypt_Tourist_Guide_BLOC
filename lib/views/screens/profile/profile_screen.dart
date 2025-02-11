import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_bloc.dart';
import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_events.dart';
import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_states.dart';
import 'package:egypt_tourist_guide/controllers/profile_bloc/profile_bloc.dart';
import 'package:egypt_tourist_guide/controllers/theme_bloc/theme_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:egypt_tourist_guide/core/app_images.dart';
import 'package:egypt_tourist_guide/core/app_routes.dart';
import 'package:egypt_tourist_guide/views/screens/profile/widgets/log_out_button.dart';
import 'package:egypt_tourist_guide/views/screens/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:egypt_tourist_guide/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('profile_updated_successfully'.tr()),
              backgroundColor: AppColors.green,
            ),
          );
        }
        if (state is ProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('fix_form_errors'.tr()),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        ProfileBloc profileBloc = context.read<ProfileBloc>();
        AuthBloc authBloc = context.read<AuthBloc>();
        bool isEditing = profileBloc.isEditing;
        UserModel user = profileBloc.user;
        if (state is ProfileLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(AppImages.user),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'dark_theme'.tr(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            ThemeBloc themeBloc = context.read<ThemeBloc>();
                            return Switch(
                                value: themeBloc.theme == 'dark',
                                splashRadius: 10,
                                onChanged: (value) {
                                  themeBloc.add(ToggleThemeEvent());
                                });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'profile_details'.tr(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Save Button
                        IconButton(
                          icon: Icon(
                            isEditing ? Icons.save : Icons.edit_note_rounded,
                            size: 30,
                          ),
                          onPressed: () {
                            if (isEditing) {
                              if (_formKey.currentState!.validate()) {
                                profileBloc.add(UpdateProfileEvent(user));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('fix_form_errors'.tr()),
                                    backgroundColor: AppColors.red,
                                  ),
                                );
                              }
                            } else {
                              profileBloc.add(ToggleEditingEvent());
                            }
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    ProfileCard(
                      user: user,
                      isEditing: isEditing,
                      isPasswordVisible: profileBloc.isVisibleProfilePassword,
                      onTogglePasswordVisibility: () {
                        profileBloc.add(
                          TogglePasswordVisibilityEvent(),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    //---- Logout Button ------//
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthUnauthenticated) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.loginRoute,
                            (route) => false,
                          );
                        }
                      },
                      child: LogOutButton(
                        logOutFunction: () {
                          authBloc.add(LogoutRequested());
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.loginRoute,
                                (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
