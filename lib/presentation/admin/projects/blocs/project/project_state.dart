import '../../model/project_model.dart';

abstract class ProjectState {}

class ProjectInitialState extends ProjectState {}

class ProjectLoadingState extends ProjectState {}

class ProjectListSuccessState extends ProjectState {
  final List<Projectmodel> ProjectList;
  ProjectListSuccessState(this.ProjectList) : super();
}

class ProjectListFailedState extends ProjectState {
  final String message;
  ProjectListFailedState(this.message) : super();
}

class ProjectDeleteState extends ProjectState{}
