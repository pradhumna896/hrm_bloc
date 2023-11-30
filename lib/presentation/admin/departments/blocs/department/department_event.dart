abstract class DepartmentEvent {}

class DepartmentInitialEvent extends DepartmentEvent {}

class DepartmentDeleteEvent extends DepartmentEvent {
  final String id;
  DepartmentDeleteEvent(this.id);
}
