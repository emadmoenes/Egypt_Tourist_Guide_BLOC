import 'package:egypt_tourist_guide/controllers/theme_bloc/theme_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:egypt_tourist_guide/views/profile/widgets/log_out_button.dart';
import 'package:egypt_tourist_guide/views/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:egypt_tourist_guide/models/user_model.dart';
import 'package:egypt_tourist_guide/controllers/profile_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = ProfileController();
  bool _isEditing = false;
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  User _user = User(
    fullName: 'User Name',
    email: 'user@example.com',
    password: 'Password123@',
    phoneNumber: '01###-###-####',
    address: '123 Main Street',
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  //-- Load user data method --//
  Future<void> _loadUserData() async {
    final user = await _profileController.loadUserData();
    setState(() {
      _user = user;
    });
  }

  //-- Update user data method --//
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      await _profileController.updateUserData(_user);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('profile_updated_successfully'.tr()),
          backgroundColor: AppColors.green,
        ),
      );

      setState(() {
        _isEditing = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('fix_form_errors'.tr()),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        ThemeBloc themeBloc = context.read<ThemeBloc>();
        return Scaffold(
          body: SingleChildScrollView(
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
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/images/user.png'),
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
                          Switch(
                              value: themeBloc.theme == 'dark',
                              splashRadius: 10,
                              onChanged: (value) {
                                themeBloc.add(ToggleThemeEvent());
                              }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        thickness: 1,
                        color: themeBloc.theme == 'light'
                            ? AppColors.lightPurple
                            : Colors.deepPurpleAccent,
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
                              _isEditing ? Icons.save : Icons.edit_note_rounded,
                              color: themeBloc.theme == 'light'
                                  ? AppColors.lightPurple
                                  : Colors.deepPurpleAccent,
                              size: 30,
                            ),
                            onPressed: () {
                              if (_isEditing) {
                                _updateProfile();
                              } else {
                                setState(() {
                                  _isEditing = true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: themeBloc.theme == 'light'
                            ? AppColors.lightPurple
                            : Colors.deepPurpleAccent,
                      ),
                      ProfileCard(
                        user: _user,
                        isEditing: _isEditing,
                        isPasswordVisible: _isPasswordVisible,
                        onTogglePasswordVisibility: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      //---- Logout Button ------//
                      LogOutButton(
                        logOutFunction: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.loginRoute,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
