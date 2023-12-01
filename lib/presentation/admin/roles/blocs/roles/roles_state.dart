part of 'roles_bloc.dart';


sealed class RolesState {}

final class RolesInitialState extends RolesState {}

final class RolesLoadingState extends RolesState {}

final class RolesListSuccessState extends RolesState {
  final List<RolesModel> rolesList;
  RolesListSuccessState(this.rolesList) : super();
}

final class RolesListFailedState extends RolesState {
  final String message;
  RolesListFailedState(this.message) : super();
}
