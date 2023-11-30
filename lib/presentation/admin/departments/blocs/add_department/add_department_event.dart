abstract class AddDepartmentEvent {}

class CreateDepartmentEvent extends AddDepartmentEvent {
  final String name;
  final String description;
  final String status;
  CreateDepartmentEvent(
      {required this.name, required this.description, required this.status});
}

class UpdateDepartmentEvent extends AddDepartmentEvent {
  final int id;
  final String name;
  final String description;
  final String status;
  UpdateDepartmentEvent( 
      {required this.name, required this.description, required this.status,required this.id,});
}
