import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/data/apiClient/api_client.dart';
import 'package:hrm_bloc/presentation/admin/roles/model/roles_model.dart';

import '../../../../../core/constants/api_network.dart';

part 'roles_event.dart';
part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  NetworkHttpServices api = NetworkHttpServices();
  RolesBloc() : super(RolesInitialState()) {
    on<RolesInitialEvent>(_getRoles);
  }

  FutureOr<void> _getRoles(
    RolesInitialEvent event,
    Emitter<RolesState> emit,
  ) async {
    final payload = {
      "page": 1,
      "per_page": 20,
      "order_by": [
        {"column": "id", "order": "asc"}
      ],
      "filter_by": {}
    };
    try {
      emit(RolesLoadingState());
      var value = await api.post(ApiNetwork.roles, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(
            RolesListSuccessState(value['payload']['data'].map<RolesModel>((e) {
          return RolesModel.fromJson(e);
        }).toList()));
       
      } else {
        emit(RolesListFailedState(value["message"]));
      }
    } catch (e) {
      emit(RolesListFailedState(e.toString()));
    }
  }
}
