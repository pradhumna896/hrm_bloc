import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/blocs/project_dropdown/project_dropdown_event.dart';
import 'package:hrm_bloc/blocs/project_dropdown/project_dropdown_state.dart';
import '../../core/constants/api_network.dart';
import '../../data/apiClient/api_client.dart';


class ProjectDropdownBloc
    extends Bloc<ProjectDropdownEvent, ProjectDropdownState> {
  NetworkHttpServices api = NetworkHttpServices();
  ProjectDropdownBloc() : super(ProjectDropdownInitialState()) {
    on<ProjectDropdownInitialEvent>(_getDrodown);
  }

  FutureOr<void> _getDrodown(ProjectDropdownInitialEvent event,
      Emitter<ProjectDropdownState> emit) async {
    try {
      emit(ProjectDropdownLoadingState());
      var value = await api.post(ApiNetwork.projectDropdown, null, false);
      if (value["success"] == true) {
        emit(ProjectDropdownLoadedState(value["payload"]['data']));
      } else {
        emit(ProjectDropdownErrorState(value["message"]));
      }
    } catch (e) {
      emit(ProjectDropdownErrorState(e.toString()));
    }
  }
}
