import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_event.dart';
import '../../../../core/constants/api_network.dart';
import '../../../../data/apiClient/api_client.dart';
import 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  NetworkHttpServices api = NetworkHttpServices();
  BoardBloc() : super(BoardStateInitial()) {
    on<BoardEventInitial>(_getBoard);
    on<BoardAddNavEvent>(_addClicked);
    on<BoardUpdateNavEvent>(_updateClicked);
    on<ProjectDropDownEvent>(_getProjectDropdown);
    on<BoardAddEvent>(_addBoard);
    on<BoardDeleteEvent>(_deleteBoard);
    on<BoardUpdateEvent>(_updateBoard);
  }

  FutureOr<void> _getBoard(
    BoardEventInitial event,
    Emitter<BoardState> emit,
  ) async {
    final payload = {
      "page": 1,
      "per_page": 20,
      "order_by": [
        {"column": "id", "order": "asc"}
      ],
      "filter_by": {"title": event.search ?? ""}
    };
    try {
      emit(BoardStateLoading());
      var value =
          await api.post(ApiNetwork.boardDropdown, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(BoardStateLoaded(value["payload"]['data']));
      } else {
        emit(BoardStateError(value["message"]));
      }
    } catch (e) {
      emit(BoardStateError(e.toString()));
    }
  }

  FutureOr<void> _getProjectDropdown(
    ProjectDropDownEvent event,
    Emitter<BoardState> emit,
  ) async {
    try {
      emit(BoardStateLoading());
      var value = await api.post(ApiNetwork.projectDropdown, null, false);
      if (value["success"] == true) {
        emit(BoardStateProjectDropDown(value["payload"]['data']));
      } else {
        emit(BoardStateError(value["message"]));
      }
    } catch (e) {
      emit(BoardStateError(e.toString()));
    }
  }

  FutureOr<void> _addBoard(
    BoardAddEvent event,
    Emitter<BoardState> emit,
  ) async {
    try {
      final payload = {
        "project_id": event.projectId,
        "title": event.title,
      };
      print(payload);

      emit(BoardStateLoading());
      var value = await api.post(ApiNetwork.createBoard, payload, false);
      if (value["success"] == true) {
        emit(BoardStateAdd());
      } else {
        emit(BoardStateError(value["message"]));
      }
    } catch (e) {
      emit(BoardStateError(e.toString()));
    }
  }

  FutureOr<void> _deleteBoard(
    BoardDeleteEvent event,
    Emitter<BoardState> emit,
  ) async {
    try {
      emit(BoardStateLoading());
      var value = await api.delete(
        ApiNetwork.boardDelete + event.id.toString(),
      );
      if (value["success"] == true) {
        emit(BoardStateDelete());
      } else {
        emit(BoardStateError(value["message"]));
      }
    } catch (e) {
      emit(BoardStateError(e.toString()));
    }
  }

  FutureOr<void> _updateBoard(
    BoardUpdateEvent event,
    Emitter<BoardState> emit,
  ) async {
    try {
      final payload = {
        'id': event.id.toString(),
        "project_id": event.projectId.toString(),
        "title": event.title,
      };
      print(payload);

      emit(BoardStateLoading());
      var value = await api.put(
          ApiNetwork.updateBoard + event.id.toString(), payload, false);
      if (value["success"] == true) {
        emit(BoardStateUpdate());
      } else {
        emit(BoardStateError(value["message"]));
      }
    } catch (e) {
      emit(BoardStateError(e.toString()));
    }
  }

  FutureOr<void> _addClicked(
    BoardAddNavEvent event,
    Emitter<BoardState> emit,
  ) {
    emit(BoardStateAddNav());
  }

  FutureOr<void> _updateClicked(
    BoardUpdateNavEvent event,
    Emitter<BoardState> emit,
  ) {
    emit(BoardStateUpdateNav(
      user: event.user,
    ));
  }
}
