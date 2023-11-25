abstract class AuthEvent {}

class AuthEventStarted extends AuthEvent {}

class AuthEventLoggedIn extends AuthEvent {
  final String email;
  final String password;
  AuthEventLoggedIn({required this.email, required this.password});
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String email;
  VerifyOtpEvent({required this.otp, required this.email});
}

class AuthEventLoggedOut extends AuthEvent {}
