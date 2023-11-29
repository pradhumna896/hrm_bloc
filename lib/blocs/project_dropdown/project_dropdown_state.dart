class ProjectDropdownState {}

class ProjectDropdownInitialState extends ProjectDropdownState {}

class ProjectDropdownLoadingState extends ProjectDropdownState {}

class ProjectDropdownLoadedState extends ProjectDropdownState {
  final List<dynamic> projects;
  ProjectDropdownLoadedState(this.projects);
}

class ProjectDropdownErrorState extends ProjectDropdownState {
  final String message;
  ProjectDropdownErrorState(this.message);
}
