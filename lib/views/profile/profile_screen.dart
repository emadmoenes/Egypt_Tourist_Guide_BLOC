import 'package:egypt_tourist_guide/core/Blocs/theme/theme_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:egypt_tourist_guide/views/profile/widgets/editable_field.dart';
import 'package:egypt_tourist_guide/views/profile/widgets/log_out_button.dart';
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
    var themeBloc = context.read<ThemeBloc>();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      const SizedBox(height: 10),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return Switch(
                              value: themeBloc.theme == 'dark',
                              onChanged: (value) {
                                themeBloc.add(ToggleThemeEvent(
                                    theme: value ? 'dark' : 'light'));
                              });
                        },
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        thickness: 1,
                        color: AppColors.lightPurple,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'profile_details'.tr(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Save Button
                          IconButton(
                            icon: Icon(
                              _isEditing ? Icons.save : Icons.edit_note_rounded,
                              color: AppColors.lightPurple,
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
                        color: AppColors.lightPurple,
                      ),
                      Card(
                        color: AppColors.lightPurple2.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditableField(
                                label: 'full_name'.tr(),
                                value: _user.fullName,
                                onChanged: (value) => _user.fullName = value,
                                isEditing: _isEditing,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'validation_full_name'.tr();
                                  }
                                  return null;
                                },
                              ),
                              const Divider(height: 20),
                              EditableField(
                                label: 'email'.tr(),
                                value: _user.email,
                                onChanged: (value) => _user.email = value,
                                isEditing: _isEditing,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'validation_email'.tr();
                                  }
                                  if (!value.contains('@') ||
                                      !value.contains('.')) {
                                    return 'validation_email_invalid'.tr();
                                  }
                                  return null;
                                },
                              ),
                              const Divider(height: 20),
                              EditableField(
                                label: 'password'.tr(),
                                value: _user.password,
                                onChanged: (value) => _user.password = value,
                                isEditing: _isEditing,
                                isPassword: true,
                                isPasswordVisible: _isPasswordVisible,
                                onTogglePasswordVisibility: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'validation_password_empty'.tr();
                                  }
                                  if (value.length < 8) {
                                    return 'validation_password_length'.tr();
                                  }
                                  if (!value.contains(RegExp(r'[A-Z]'))) {
                                    return 'validation_password_uppercase'.tr();
                                  }
                                  if (!value.contains(RegExp(r'[a-z]'))) {
                                    return 'validation_password_lowercase'.tr();
                                  }
                                  if (!value.contains(RegExp(r'[0-9]'))) {
                                    return 'validation_password_digit'.tr();
                                  }
                                  if (!value.contains(
                                      RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                    return 'validation_password_special'.tr();
                                  }
                                  return null;
                                },
                              ),
                              const Divider(height: 20),
                              EditableField(
                                label: 'phone_number'.tr(),
                                value: _user.phoneNumber ?? '',
                                onChanged: (value) => _user.phoneNumber = value,
                                isEditing: _isEditing,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'validation_phone_number_empty'.tr();
                                  }
                                  if (value.length < 10) {
                                    return 'validation_phone_number_invalid'
                                        .tr();
                                  }
                                  return null;
                                },
                              ),
                              const Divider(height: 20),
                              EditableField(
                                label: 'address'.tr(),
                                value: _user.address ?? '',
                                onChanged: (value) => _user.address = value,
                                isEditing: _isEditing,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'validation_address_empty'.tr();
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //---- Logout Button ------//
                      LogOutButton(
                        logOutFunction: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
////////////////////////////////////////////
