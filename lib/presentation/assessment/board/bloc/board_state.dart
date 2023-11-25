abstract class BoardState {}

class BoardStateInitial extends BoardState {}

class BoardStateLoading extends BoardState {}

class BoardStateLoaded extends BoardState {
  final List<dynamic> boards;

  BoardStateLoaded(this.boards);
}

class BoardStateError extends BoardState {
  final String message;

  BoardStateError(this.message);
}

class BoardStateAddNav extends BoardState {}

class BoardStateUpdateNav extends BoardState{
  final Map user;
  BoardStateUpdateNav({required this.user});
}

class BoardStateProjectDropDown extends BoardState {
  final List<dynamic> projects;

  BoardStateProjectDropDown(this.projects);
}

class BoardStateAdd extends BoardState {}

class BoardStateUpdate extends BoardState {}



class BoardStateDelete extends BoardState {}
