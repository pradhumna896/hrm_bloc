import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/data/apiClient/api_client.dart';
import 'package:hrm_bloc/presentation/admin/departments/model/department_model.dart';
import 'package:hrm_bloc/presentation/admin/projects/model/project_model.dart';
import '../../../../../core/constants/api_network.dart';
import 'project_event.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  NetworkHttpServices api = NetworkHttpServices();
  ProjectBloc() : super(ProjectInitialState()) {
    on<ProjectInitialEvent>(_getProject);
    on<ProjectDeleteEvent>(_deleteProject);
  }

  FutureOr<void> _getProject(
      ProjectInitialEvent event, Emitter<ProjectState> emit) async {
    final payload = {
      "page": 1,
      "per_page": 20,
      "order_by": [
        {"column": "id", "order": "asc"}
      ],
      "filter_by": {}
    };
    try {
      emit(ProjectLoadingState());
      var value =
          await api.post(ApiNetwork.projects, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(ProjectListSuccessState(
            value['payload']['data'].map<Projectmodel>((e) {
          return Projectmodel.fromJson(e);
        }).toList()));
      } else {
        emit(ProjectListFailedState(value["message"]));
      }
    } catch (e) {
      emit(ProjectListFailedState(e.toString()));
    }
  }

  FutureOr<void> _deleteProject(
    ProjectDeleteEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      emit(ProjectLoadingState());
      var value = await api.delete(ApiNetwork.projectDelete + event.id);
      if (value["success"] == true) {
        emit(ProjectDeleteState());
      } else {
        emit(ProjectListFailedState(value["message"]));
      }
    } catch (e) {
      emit(ProjectListFailedState(e.toString()));
    }
  }
}
