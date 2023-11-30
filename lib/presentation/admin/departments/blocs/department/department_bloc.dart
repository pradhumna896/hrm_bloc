import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/data/apiClient/api_client.dart';
import 'package:hrm_bloc/presentation/admin/departments/model/department_model.dart';
import '../../../../../core/constants/api_network.dart';
import 'department_event.dart';
import 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  NetworkHttpServices api = NetworkHttpServices();
  DepartmentBloc() : super(DepartmentInitialState()) {
    on<DepartmentInitialEvent>(_getDepartment);
    on<DepartmentDeleteEvent>(_deleteDepartment);
  }

  FutureOr<void> _getDepartment(
      DepartmentInitialEvent event, Emitter<DepartmentState> emit) async {
    final payload = {
      "page": 1,
      "per_page": 20,
      "order_by": [
        {"column": "id", "order": "asc"}
      ],
      "filter_by": {}
    };
    try {
      emit(DepartmentLoadingState());
      var value =
          await api.post(ApiNetwork.departments, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(DepartmentListSuccessState(
            value['payload']['data'].map<DepartmentModel>((e) {
          return DepartmentModel.fromJson(e);
        }).toList()));
      } else {
        emit(DepartmentListFailedState(value["message"]));
      }
    } catch (e) {
      emit(DepartmentListFailedState(e.toString()));
    }
  }

  FutureOr<void> _deleteDepartment(
    DepartmentDeleteEvent event,
    Emitter<DepartmentState> emit,
  ) async {
    try {
      emit(DepartmentLoadingState());
      var value = await api.delete(ApiNetwork.departmentDelete + event.id);
      if (value["success"] == true) {
        emit(DepartmentDeleteState());
      } else {
        emit(DepartmentListFailedState(value["message"]));
      }
    } catch (e) {
      emit(DepartmentListFailedState(e.toString()));
    }
  }
}
