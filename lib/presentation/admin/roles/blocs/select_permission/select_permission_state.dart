part of 'select_permission_bloc.dart';

sealed class SelectPermissionState {}

final class SelectPermissionInitial extends SelectPermissionState {
  final List<dynamic> addPermission;
  SelectPermissionInitial(this.addPermission);
}

