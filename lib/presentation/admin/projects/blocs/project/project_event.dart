abstract class ProjectEvent {}

class ProjectInitialEvent extends ProjectEvent {}

class ProjectDeleteEvent extends ProjectEvent {
  final String id;
  ProjectDeleteEvent(this.id);
}
