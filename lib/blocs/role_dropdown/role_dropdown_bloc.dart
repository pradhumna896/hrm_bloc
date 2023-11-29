import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/blocs/role_dropdown/role_dropdown_event.dart';

import 'package:hrm_bloc/blocs/role_dropdown/role_dropdown_state.dart';

import '../../core/constants/api_network.dart';
import '../../data/apiClient/api_client.dart';

class RoleDropdownBloc extends Bloc<RoleDropdownEvent, RoleDropdownState> {
  NetworkHttpServices api = NetworkHttpServices();
  RoleDropdownBloc() : super(RoleDropdownInitialState()) {
    on<RoleDropdownInitialEvent>(_getDrodown);
  }

  FutureOr<void> _getDrodown(
      RoleDropdownInitialEvent event, Emitter<RoleDropdownState> emit) async {
    try {
      emit(RoleDropdownLoadingState());
      var value = await api.post(ApiNetwork.roleDropdown, null, false);
      if (value["success"] == true) {
        emit(RoleDropdownLoadedState(value["payload"]['data']));
      } else {
        emit(RoleDropdownErrorState(value["message"]));
      }
    } catch (e) {
      emit(RoleDropdownErrorState(e.toString()));
    }
  }
}
