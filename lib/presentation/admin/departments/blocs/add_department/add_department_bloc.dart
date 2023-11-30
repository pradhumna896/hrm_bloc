import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/data/apiClient/api_client.dart';
import '../../../../../core/constants/api_network.dart';
import 'add_department_event.dart';
import 'add_department_state.dart';

class AddDepartmentBloc extends Bloc<AddDepartmentEvent, AddDepartmentState> {
  NetworkHttpServices api = NetworkHttpServices();

  AddDepartmentBloc() : super(DepartmentInitialState()) {
    on<CreateDepartmentEvent>(_createDepartment);
    on<UpdateDepartmentEvent>(_updateDepartment);
  }

  FutureOr<void> _createDepartment(
    CreateDepartmentEvent event,
    Emitter<AddDepartmentState> emit,
  ) async {
    try {
      final payload = {
        "name": event.name,
        "description": event.description,
        "status": event.status,
      };
      print(payload);

      emit(DepartmentLoadingState());
      var value = await api.post(ApiNetwork.createDepartment, payload, false);
      if (value["success"] == true) {
        emit(CreateDepartmentState());
      } else {
        emit(DemartmentFaild(value["message"]));
      }
    } catch (e) {
      emit(DemartmentFaild(e.toString()));
    }
  }

  FutureOr<void> _updateDepartment(
      UpdateDepartmentEvent event, Emitter<AddDepartmentState> emit) async {
    try {
      final payload = {
        "name": event.name,
        "description": event.description,
        "status": event.status,
      };
      print(payload);
      emit(DepartmentLoadingState());
      var value = await api.put(
          ApiNetwork.updateDepartment + event.id.toString(), payload, false);
      if (value["success"] == true) {
        emit(UpdateDepartmentState());
      } else {
        emit(DemartmentFaild(value["message"]));
        }
    } catch (e) {
      emit(DemartmentFaild(e.toString()));
      }
      }
}
