import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/bloc/user_event.dart';
import 'package:hrm_bloc/presentation/user_management/users/bloc/user_state.dart';
import '../../../../core/constants/api_network.dart';
import '../../../../data/apiClient/api_client.dart';

class UserBloc extends Bloc<UsersEvent, UserState> {
  UserBloc() : super(UserStateInitial()) {
    NetworkHttpServices api = NetworkHttpServices();
    on<UserAddNavigationEvent>((event, emit) {
      emit(UserAddNavigationState());
    });
    on<UsersEventInitial>((event, emit) async {
      try {
        emit(UserStateLoading());
        var value = await api.post(ApiNetwork.users, null, false);
        if (value["success"] == true) {
          emit(UserStateLoaded(value["payload"]['data']));
        } else {
          emit(UserStateError(value["message"]));
        }
      } catch (e) {
        emit(UserStateError(e.toString()));
      }
    });

    on<UsersEventDeleteUser>((event, emit) async {
      try {
        emit(UserStateLoading());
        var value = await api.delete(
          ApiNetwork.deleteUsers + event.id,
        );
        if (value["success"] == true) {
          emit(UserStateDeleted());
        } else {
          emit(UserStateError(value["message"]));
        }
      } catch (e) {
        emit(UserStateError(e.toString()));
      }
    });
  }
}
