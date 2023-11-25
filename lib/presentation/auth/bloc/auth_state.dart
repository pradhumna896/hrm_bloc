abstract class AuthState{} 

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLoggedIn extends AuthState {}

class AuthVerifiedState extends AuthState{}

class AuthStateLoggedOut extends AuthState {}

class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
}

