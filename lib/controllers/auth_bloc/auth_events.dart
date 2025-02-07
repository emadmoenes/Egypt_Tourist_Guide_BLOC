abstract class AuthEvent {}

// InitAuthEvent when the app starts
class InitAuthEvent extends AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

class SignUpRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String? phoneNumber;

  SignUpRequested({
    required this.fullName,
    required this.email,
    required this.password,
    this.phoneNumber,
  });
}

class LogoutRequested extends AuthEvent {}
