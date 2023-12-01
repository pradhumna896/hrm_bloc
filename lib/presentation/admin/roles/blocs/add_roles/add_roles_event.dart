part of 'add_roles_bloc.dart';

sealed class AddRolesEvent {}

class AddRolesInitialEvent extends AddRolesEvent {}

class CreateRoleEvent extends AddRolesEvent {
  final String name;
  final List<dynamic> permissions;
  CreateRoleEvent(this.name, this.permissions);
}

class UpdateRoleEvent extends AddRolesEvent {
  final String name;
  final List<dynamic> permissions;
  final String slug;
  UpdateRoleEvent(this.name, this.permissions, this.slug);
}
