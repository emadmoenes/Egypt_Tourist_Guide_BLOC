import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_bloc.dart';
import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_events.dart';
import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_states.dart';
import 'package:egypt_tourist_guide/core/app_routes.dart';
import 'package:egypt_tourist_guide/views/auth/widgets/auth_button.dart';
import 'package:egypt_tourist_guide/views/auth/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/app_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/signup_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: Icon(Icons.language, color: Colors.white, size: 30),
                onPressed: () {
                  final newLocale = context.locale.languageCode == 'en'
                      ? Locale('ar')
                      : Locale('en');
                  context.setLocale(newLocale);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'signup'.tr(),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black87Color,
                            ),
                          ),
                          const SizedBox(height: 35),
                          CustomTextFormField(
                            controller: _fullNameController,
                            labelText: 'full_name',
                            hintText: 'enter_full_name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'validation_full_name'.tr();
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            controller: _emailController,
                            labelText: 'email',
                            hintText: 'email_hint',
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
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            controller: _passwordController,
                            labelText: 'password',
                            hintText: 'password_hint',
                            obscureText: !_isPasswordVisible,
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            controller: _confirmPasswordController,
                            labelText: 'confirm_password',
                            hintText: 'confirm_password_hint',
                            obscureText: !_isConfirmPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'validation_confirm_password'.tr();
                              }
                              if (value != _passwordController.text) {
                                return 'validation_confirm_password_match'.tr();
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            controller: _phoneController,
                            labelText: 'phone_number',
                            hintText: 'phone_number_hint',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 35),
                          AuthButton(
                            buttonText: 'signup'.tr(),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignUpRequested(
                                        fullName: _fullNameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        phoneNumber: _phoneController.text,
                                      ),
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
