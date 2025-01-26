import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_events.dart';
import 'package:egypt_tourist_guide/controllers/auth_bloc/auth_states.dart';
import 'package:egypt_tourist_guide/core/services/shared_prefs_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<InitAuthEvent>(_initAuth);
  }

  //handle init auth event when app starts
  Future<void> _initAuth(InitAuthEvent event, Emitter<AuthState> emit) async {
    String? token = await SharedPrefsService.getStringData(key: "token");
    if (token != null) {
      emit(AuthAuthenticated());
    }
  }

  // handle login request event
  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final userData = await SharedPrefsService.getUserData();
      if (userData['email'] == event.email &&
          userData['password'] == event.password) {
        emit(AuthAuthenticated());
        // save dummy token
        await SharedPrefsService.saveStringData(key: "token", value: "done");
      } else {
        emit(AuthError(message: 'Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError(message: 'An error occurred'));
    }
  }

  // handle sign up request event
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await SharedPrefsService.saveUserData(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        phoneNumber: event.phoneNumber,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(message: 'Failed to sign up'));
    }
  }

  // handle logout request event
  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await SharedPrefsService.clearUserData();
    await SharedPrefsService.clearStringData(key: "token");
    emit(AuthUnauthenticated());
  }
}
