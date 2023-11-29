import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_event.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_state.dart';
import '../../../../core/constants/api_network.dart';
import '../../../../data/apiClient/api_client.dart';
import '../model/manpower_model.dart';

class ManpowerBloc extends Bloc<ManpowerEvent, ManpowerState> {
  NetworkHttpServices api = NetworkHttpServices();

  ManpowerBloc() : super(ManpowerInitial()) {
    on<ManpowerInitialEvent>(_getManpower);
    on<ManpowerAddEvent>(_addManpower);
  }

  FutureOr<void> _getManpower(
      ManpowerInitialEvent event, Emitter<ManpowerState> emit) async {
    final payload = {
      "page": 1,
      "per_page": 20,
      "order_by": [
        {"column": "id", "order": "asc"}
      ],
      "filter_by": {}
    };
    try {
      emit(GetManpowerLoading());
      var value =
          await api.post(ApiNetwork.manpowers, jsonEncode(payload), true);
      if (value["success"] == true) {
        emit(GetManpowerListSuccess(
            value['payload']['data'].map<ManpowerModel>((e) {
          return ManpowerModel.fromJson(e);
        }).toList()));
      } else {
        emit(GetManpowerListFailed(value["message"]));
      }
    } catch (e) {
      emit(GetManpowerListFailed(e.toString()));
    }
  }

  FutureOr<void> _addManpower(
      ManpowerAddEvent event, Emitter<ManpowerState> emit) async {
    final payload = {
      "user": {
        "name": event.name,
        "email": event.email,
        "phone": event.phone,
        "role": event.role,
      },
      "manpower": {
        "address": event.address,
        "bank_account_name": event.bankAccountName,
        "bank_account_number": event.accountNumber,
        "bank_branch": event.branchName,
        "bank_city": event.branchCity,
        "bank_ifsc_code": event.ifscCode,
        "bank_name": event.bankName,
        "benifits": event.benifit,
        "city": event.city,
        "country": event.country,
        "date_of_birth": event.dateOfBirth,
        "date_of_joining": event.joinOfDate,
        "department_id": event.department,
        "designation": event.designation,
        "emergency_number": event.emergencyNumber,
        "employee_status": event.employeeStatus,
        "gender": event.gender,
        "marital_status": event.material,
        "employee_type": event.employeeType,
        "leave_balance": event.leaveBalance,
        "pincode": event.pincode,
        "probabation_period": event.probationPeriod,
        "rating": event.rating,
        "salary": event.salary,
        "state": event.state,
      }
    };

    try {
      emit(GetManpowerLoading());
      var value =
          await api.post(ApiNetwork.manpowerCreate, jsonEncode(payload), true);
      if (value["success"] == true) {
        print(value);
        emit(ManpowerAddState());
      } else {
        print(value["message"]);
        emit(GetManpowerListFailed(value["message"]));
      }
    } catch (e) {
      print(e.toString());
      emit(GetManpowerListFailed(e.toString()));
    }
  }
}
