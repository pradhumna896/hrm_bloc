class RoleDropdownState {}

class RoleDropdownInitialState extends RoleDropdownState {}

class RoleDropdownLoadingState extends RoleDropdownState {}

class RoleDropdownLoadedState extends RoleDropdownState {
  final List<dynamic> roles;
  RoleDropdownLoadedState(this.roles);
}

class RoleDropdownErrorState extends RoleDropdownState {
  final String message;
  RoleDropdownErrorState(this.message);
}
