part of 'add_roles_bloc.dart';

sealed class AddRolesEvent {}

class AddRolesInitialEvent extends AddRolesEvent {}

class CreateRoleEvent extends AddRolesEvent {
  final String name;
  final List<String> permissions;
  CreateRoleEvent(this.name, this.permissions);
}
