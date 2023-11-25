import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/core/constants/api_network.dart';
import '../../../core/constants/session_manager.dart';
import '../../../data/apiClient/api_client.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    NetworkHttpServices api = NetworkHttpServices();
    on<AuthEventLoggedIn>((event, emit) async {
      try {
        var payload = {
          "email": event.email,
          "password": event.password,
          'logout_all': 'true'
        };
        emit(AuthStateLoading());
        var value = await api.post(ApiNetwork.login, payload, false);
        if (value["success"] == true) {
          emit(AuthStateLoggedIn());
        } else {
          emit(AuthStateError(value["message"]));
        }
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });
    on<VerifyOtpEvent>((event, emit) async {
      try {
        var payload = {
          "email": event.email,
          "otp": event.otp,
        };
        emit(AuthStateLoading());
        var value = await api.post(ApiNetwork.loginVerify, payload, false);
        if (value["success"] == true) {
          var jsonData = json.encode(value['payload']);

          await SessionManager.setToken(value['payload']['token']['token']);
          await SessionManager.setUser(jsonData);
          await SessionManager.setUserId(value["payload"]["id"].toString());
          await SessionManager.setRole(value["payload"]["role"]["name"]);
          emit(AuthVerifiedState());
        } else {
          emit(AuthStateError(value["message"]));
        }
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });
  }
}
