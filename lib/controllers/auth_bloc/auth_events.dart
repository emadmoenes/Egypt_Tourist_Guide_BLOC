abstract class AuthEvent {}

// Login event
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

// sign up event
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

// log out event
class LogoutRequested extends AuthEvent {}
