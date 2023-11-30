import '../../model/department_model.dart';

abstract class DepartmentState {}

class DepartmentInitialState extends DepartmentState {}

class DepartmentLoadingState extends DepartmentState {}

class DepartmentListSuccessState extends DepartmentState {
  final List<DepartmentModel> departmentList;
  DepartmentListSuccessState(this.departmentList) : super();
}

class DepartmentListFailedState extends DepartmentState {
  final String message;
  DepartmentListFailedState(this.message) : super();
}

class DepartmentDeleteState extends DepartmentState{}
