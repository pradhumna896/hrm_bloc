import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/blocs/department_dropdown/dept_dropdown_state.dart';

import '../../core/constants/api_network.dart';
import '../../data/apiClient/api_client.dart';
import 'dept_dropdown_event.dart';

class DeptDropdownBloc extends Bloc<DeptDropdownEvent, DeptDropdownState> {
  NetworkHttpServices api = NetworkHttpServices();
  DeptDropdownBloc() : super(DeptDropdownInitialState()) {
    on<DeptDropdownInitialEvent>(_getDrodown);
  }

  FutureOr<void> _getDrodown(
      DeptDropdownInitialEvent event, Emitter<DeptDropdownState> emit) async {
    try {
      emit(DeptDropdownLoadingState());
      var value = await api.post(ApiNetwork.departmentDropdown, null, false);
      if (value["success"] == true) {
        emit(DeptDropdownLoadedState(value["payload"]['data']));
      } else {
        emit(DeptDropdownErrorState(value["message"]));
      }
    } catch (e) {
      emit(DeptDropdownErrorState(e.toString()));
    }
  }
}
