import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hrm_bloc/core/constants/api_network.dart';
import 'package:hrm_bloc/data/apiClient/api_client.dart';
import 'package:hrm_bloc/presentation/admin/roles/model/permission_model.dart';

part 'add_roles_event.dart';
part 'add_roles_state.dart';

class AddRolesBloc extends Bloc<AddRolesEvent, AddRolesState> {
  NetworkHttpServices api = NetworkHttpServices();
  AddRolesBloc() : super(AddRolesInitialStae()) {
    on<AddRolesInitialEvent>(_getPermission);
    on<CreateRoleEvent>(_createRoles);
    on<UpdateRoleEvent>(_updateRoles);
  }

  FutureOr<void> _getPermission(
      AddRolesInitialEvent event, Emitter<AddRolesState> emit) async {
    try {
      emit(AddRolesLoadingState());
      var value = await api.post(ApiNetwork.permission, null, false);
      if (value["success"] == true) {
        emit(AddRolesListSuccessState(
            value['payload'].map<PermmissionModel>((e) {
          return PermmissionModel.fromJson(e);
        }).toList()));
      } else {
        emit(AddRolesListFailedState(value["message"]));
      }
    } catch (e) {
      emit(AddRolesListFailedState(e.toString()));
    }
  }

  FutureOr<void> _createRoles(
    CreateRoleEvent event,
    Emitter<AddRolesState> emit,
  ) async {
    final payload = {
      "name": event.name,
      "permissions": event.permissions,
    };
    print(payload);

    try {
      emit(AddRolesLoadingState());
      var value =
          await api.post(ApiNetwork.roleCreate, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(CreateRolesState());
      } else {
        emit(AddRolesListFailedState(value["message"]));
      }
    } catch (e) {
      emit(AddRolesListFailedState(e.toString()));
    }
  }

  FutureOr<void> _updateRoles(
    UpdateRoleEvent event,
    Emitter<AddRolesState> emit,
  ) async {
    final payload = {
      "name": event.name,
      "permissions": event.permissions,
    };
    print(payload);
    try {
      emit(AddRolesLoadingState());
      var value = await api.put(
          ApiNetwork.roleUpdate + event.slug, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(UpdateRolesState());
      } else {
        emit(AddRolesListFailedState(value["message"]));
      }
    } catch (e) {
      emit(AddRolesListFailedState(e.toString()));
    }
  }
}
