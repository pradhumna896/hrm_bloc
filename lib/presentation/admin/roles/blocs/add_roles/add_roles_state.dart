part of 'add_roles_bloc.dart';


sealed class AddRolesState {}

 class AddRolesInitialStae extends AddRolesState {}

  class AddRolesLoadingState extends AddRolesState {}

  class AddRolesListSuccessState extends AddRolesState {
  final List<PermmissionModel> rolesPermissionList;
  AddRolesListSuccessState(this.rolesPermissionList) : super();
}

  class AddRolesListFailedState extends AddRolesState {
  final String message;
  AddRolesListFailedState(this.message) : super();
}

  class AddRole extends AddRolesState {
  final String message;
  AddRole(this.message) : super();
}

class CreateRolesState extends AddRolesState{}
