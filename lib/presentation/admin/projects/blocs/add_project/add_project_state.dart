abstract class AddProjectState {}

class ProjectInitialState extends AddProjectState {}

class ProjectLoadingState extends AddProjectState {}

class CreateProjectState extends AddProjectState {}

class UpdateProjectState extends AddProjectState {}

class ProjectFailed extends AddProjectState {
  final String message;
  ProjectFailed(this.message);
}
