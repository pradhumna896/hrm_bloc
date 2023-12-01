part of 'select_permission_bloc.dart';

sealed class SelectPermissionEvent {}

class PermissionAddd extends SelectPermissionEvent {
  final String id;
  PermissionAddd(this.id);
}

class PermissionRemove extends SelectPermissionEvent {
  final String id;
  PermissionRemove(this.id);
}
