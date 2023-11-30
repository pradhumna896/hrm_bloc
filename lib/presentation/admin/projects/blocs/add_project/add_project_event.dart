abstract class AddProjectEvent {}

class CreateProjectEvent extends AddProjectEvent {
  final String name;
  final String? description;
  final String status;
  final String type;
  final String startDate;
  final String? endDate;
  CreateProjectEvent({
    required this.type,
    this.endDate,
    required this.name,
    required this.description,
    required this.status,
    required this.startDate,
  });
}

class UpdateProjectEvent extends AddProjectEvent {
  final int id;
  final String name;
  final String? description;
  final String status;
  final String? type;
  final String startDate;
  final String? endDate;
  UpdateProjectEvent(
    { this.type,
    required this.startDate,
    this.endDate,
    required this.name,
    required this.description,
    required this.status,
    required this.id,
  });
}
