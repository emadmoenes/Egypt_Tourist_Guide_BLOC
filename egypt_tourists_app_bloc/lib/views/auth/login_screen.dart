import 'package:egypt_tourists_app_bloc/controllers/auth_controller.dart';
import 'package:egypt_tourists_app_bloc/services/shared_prefs_service.dart';
import 'package:egypt_tourists_app_bloc/views/auth/widgets/auth_button.dart';
import 'package:egypt_tourists_app_bloc/views/auth/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/app_images.dart';
import '../../core/app_routes.dart';
import '../../../core/app_colors.dart';

// this is the login screen widget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hiddenPassword = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = AuthController();

  /*-------------- Methods ----------------*/
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_email'.tr();
    }
    if (!value.contains('@')) {
      return 'validation_email_at'.tr();
    }
    if (!value.contains('.')) {
      return 'validation_email_dot'.tr();
    }
    return null;
  }

  void togglePasswordVisibility() {
    setState(() {
      hiddenPassword = !hiddenPassword;
    });
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      final userData = await SharedPrefsService.getUserData();

      if (userData['email'] == email && userData['password'] == password) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('invalid_credentials'.tr())),
        );
      }
    }
  }

  /*------------ End of Methods --------------*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.pyramids,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon:
                  const Icon(Icons.language, color: AppColors.white, size: 30),
              onPressed: () {
                // Toggle between English and Arabic
                final newLocale = context.locale.languageCode == 'en'
                    ? Locale('ar')
                    : Locale('en');
                context.setLocale(newLocale);
              },
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'login'.tr(),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black87Color,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        //---- Email Form Field ----//
                        CustomTextFormField(
                          controller: emailController,
                          labelText: 'email',
                          hintText: 'email_hint',
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 16.0),
                        //---- Password Form Field ----//
                        CustomTextFormField(
                          controller: passwordController,
                          labelText: 'password',
                          hintText: 'password_hint',
                          obscureText: hiddenPassword,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'validation_password_empty'.tr();
                            }
                            if (value!.length < 6) {
                              return 'validation_password_length'.tr();
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: togglePasswordVisibility,
                            icon: Icon(
                              hiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        //---- Login button ----//
                        AuthButton(
                          onPressed: _login,
                          buttonText: 'login'.tr(),
                        ),
                        const SizedBox(height: 16.0),
                        // Sign up prompt
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.signupRoute);
                          },
                          child: Text(
                            'signup_prompt'.tr(),
                            style: const TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
