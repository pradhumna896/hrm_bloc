import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hrm_bloc/data/apiClient/api_client.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants/api_network.dart';
import '../../model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  NetworkHttpServices api = NetworkHttpServices();
  TaskBloc() : super(TaskInitial()) {
    on<TaskInitialEvent>(_getTask);
  }

  FutureOr<void> _getTask(
      TaskInitialEvent event, Emitter<TaskState> emit) async {
    try {
      var payload = {
        "page": 1,
        "per_page": 20,
        "order_by": [
          {"column": "id", "order": "asc"}
        ],
        "filter_by": {}
      };
      emit(TaskLoading());
      var value = await api.post(ApiNetwork.tasks, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(TaskLoaded(value['payload']['data'].map<TaskModel>((e) {
          return TaskModel.fromJson(e);
        }).toList()));
      } else {
        emit(TaskError(value["message"]));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
