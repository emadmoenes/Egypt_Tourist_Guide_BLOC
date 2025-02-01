import 'dart:developer';

import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_events.dart';
import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_states.dart';
import 'package:egypt_tourist_guide/core/app_strings_en.dart';
import 'package:egypt_tourist_guide/core/services/firebase_service.dart';
import 'package:egypt_tourist_guide/core/services/shared_prefs_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<InitAuthEvent>(_initAuth);
  }

  // handle init auth event when app starts
  Future<void> _initAuth(InitAuthEvent event, Emitter<AuthState> emit) async {
    String? token =
        await SharedPrefsService.getStringData(key: AppStringEn.tokenKey);
    if (token != null) {
      emit(AuthAuthenticated());
    }
  }

  // handle login request event
  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      // login using firebase auth
      final user = await FirebaseService.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      // save token in shared prefs
      await SharedPrefsService.saveStringData(
        key: AppStringEn.tokenKey,
        value: user!.uid,
      );
      emit(AuthAuthenticated());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError(message: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(AuthError(message: 'An error occurred'));
    }
  }

  // handle sign up request event
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      // sign up using firebase auth
      final user = await FirebaseService.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      log(user!.uid);
      //--> save user data in firestore database then, save doc id in shared prefs ----
      // await SharedPrefsService.saveUserData(
      //   fullName: event.fullName,
      //   email: event.email,
      //   password: event.password,
      //   phoneNumber: event.phoneNumber,
      // );
      emit(AccountCreated());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthError(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthError(message: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(AuthError(message: 'Failed to sign up'));
    }
  }

  // handle logout request event
  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await FirebaseService.signOut();
    await SharedPrefsService.clearStringData(key: AppStringEn.tokenKey);
    emit(AuthUnauthenticated());
  }
}
