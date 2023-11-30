abstract class AddDepartmentState {}

class DepartmentInitialState extends AddDepartmentState {}

class DepartmentLoadingState extends AddDepartmentState {}

class CreateDepartmentState extends AddDepartmentState {}

class UpdateDepartmentState extends AddDepartmentState {}

class DemartmentFaild extends AddDepartmentState {
  final String message;
  DemartmentFaild(this.message);
}
