part of 'roles_bloc.dart';

sealed class RolesEvent {}

final class RolesInitialEvent extends RolesEvent {}

class RoleDeleteEvent extends RolesEvent {
  final String slug;
  RoleDeleteEvent(this.slug);
}
