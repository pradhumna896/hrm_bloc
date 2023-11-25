abstract class BoardEvent {}

class BoardEventInitial extends BoardEvent {}

class BoardAddNavEvent extends BoardEvent{}

class BoardUpdateNavEvent extends BoardEvent{
  final user;
  BoardUpdateNavEvent({this.user});
}

class ProjectDropDownEvent extends BoardEvent{}

class BoardAddEvent extends BoardEvent{
  final String? projectId;
  final String? title;
  BoardAddEvent({this.projectId,this.title});
}

class BoardUpdateEvent extends BoardEvent{
  final String? id;
  final String? projectId;
  final String? title;
  BoardUpdateEvent({this.id,this.projectId,this.title});
}



class BoardDeleteEvent extends BoardEvent{
  final String? id;
  BoardDeleteEvent({this.id});
}


