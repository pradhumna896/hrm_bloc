import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/data/apiClient/api_client.dart';
import '../../../../../core/constants/api_network.dart';
import 'add_project_event.dart';
import 'add_project_state.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  NetworkHttpServices api = NetworkHttpServices();

  AddProjectBloc() : super(ProjectInitialState()) {
    on<CreateProjectEvent>(_createProject);
    on<UpdateProjectEvent>(_updateProject);
  }

  FutureOr<void> _createProject(
    CreateProjectEvent event,
    Emitter<AddProjectState> emit,
  ) async {
    try {
      final payload = {
        "end_date": event.endDate,
        "project_description": event.description,
        "project_name": event.name,
        "project_status": event.status,
        "project_type": event.type,
        "start_date": event.startDate
      };
      print(payload);

      emit(ProjectLoadingState());
      var value = await api.post(ApiNetwork.projectCreate, payload, false);
      if (value["success"] == true) {
        emit(CreateProjectState());
      } else {
        emit(ProjectFailed(value["message"]));
      }
    } catch (e) {
      emit(ProjectFailed(e.toString()));
    }
  }

  FutureOr<void> _updateProject(
      UpdateProjectEvent event, Emitter<AddProjectState> emit) async {
    try {
      final payload = {
         "end_date": event.endDate,
        "project_description": event.description,
        "project_name": event.name,
        "project_status": event.status,
        "project_type": event.type,
        "start_date": event.startDate
      };
      print(payload);
      emit(ProjectLoadingState());
      var value = await api.put(
          ApiNetwork.projectUpdate + event.id.toString(), payload, false);
      if (value["success"] == true) {
        emit(UpdateProjectState());
      } else {
        emit(ProjectFailed(value["message"]));
      }
    } catch (e) {
      emit(ProjectFailed(e.toString()));
    }
  }
}
