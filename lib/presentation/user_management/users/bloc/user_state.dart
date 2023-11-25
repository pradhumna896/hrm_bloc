abstract class UserState{} 

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateLoaded extends UserState {
  final List<dynamic> users;

  UserStateLoaded(this.users);
}

class UserStateError extends UserState {
  final String message;

  UserStateError(this.message);
}

class UserStateDeleted extends UserState {}

class UserAddNavigationState extends UserState{}

class UserStateAdded extends UserState {}

class UserStateUpdated extends UserState {}

class UserStateSearched extends UserState {
  final List<dynamic> users;

  UserStateSearched(this.users);
}



