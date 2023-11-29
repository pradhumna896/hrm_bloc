class DeptDropdownState {}

class DeptDropdownInitialState extends DeptDropdownState {}

class DeptDropdownLoadingState extends DeptDropdownState {}

class DeptDropdownLoadedState extends DeptDropdownState {
  final List<dynamic> departments;
  DeptDropdownLoadedState(this.departments);
}

class DeptDropdownErrorState extends DeptDropdownState {
  final String message;
  DeptDropdownErrorState(this.message);
}
