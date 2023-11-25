import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_event.dart';
import '../../../../core/constants/api_network.dart';
import '../../../../data/apiClient/api_client.dart';
import 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardStateInitial()) {
    NetworkHttpServices api = NetworkHttpServices();
    on<BoardEventInitial>((event, emit) async {
      try {
        emit(BoardStateLoading());
        var value = await api.post(ApiNetwork.boardDropdown, null, false);
        if (value["success"] == true) {
          emit(BoardStateLoaded(value["payload"]['data']));
        } else {
          emit(BoardStateError(value["message"]));
        }
      } catch (e) {
        emit(BoardStateError(e.toString()));
      }
    });
    on<BoardAddNavEvent>((event, emit) async {
      emit(BoardStateAddNav());
    });
    on<BoardUpdateNavEvent>((event, emit) async {
      emit(BoardStateUpdateNav(
        user: event.user,
      ));
    });
    on<ProjectDropDownEvent>((event, emit) async {
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
    });
    on<BoardAddEvent>((event, emit) async {
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
    });
    on<BoardDeleteEvent>((event, emit) async {
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
    });
    on<BoardUpdateEvent>((event, emit) async {
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
    });
  }
}
