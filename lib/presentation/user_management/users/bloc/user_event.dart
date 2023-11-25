abstract class UsersEvent{} 

class UsersEventInitial extends UsersEvent {}

class UsersEventLoadUsers extends UsersEvent {}

class UsersEventDeleteUser extends UsersEvent {
  final String id;

  UsersEventDeleteUser(this.id);
}

class UserAddNavigationEvent extends UsersEvent{}


class UsersEventSearchUser extends UsersEvent {
  final String name;

  UsersEventSearchUser(this.name);
}


