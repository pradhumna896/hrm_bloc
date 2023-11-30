import '../model/manpower_model.dart';

abstract class ManpowerState {}

class ManpowerInitial extends ManpowerState {
  final int index;
  ManpowerInitial({this.index = 0});
}

class GetManpowerLoading extends ManpowerState {
  GetManpowerLoading() : super();
}

class GetManpowerListSuccess extends ManpowerState {
  final List<ManpowerModel> manpowerList;
  GetManpowerListSuccess(this.manpowerList) : super();
}

class GetManpowerListFailed extends ManpowerState {
  final String message;
  GetManpowerListFailed(this.message) : super();
}

class ManpowerTriggerState extends ManpowerState {
  final int index;
  ManpowerTriggerState({this.index = 0});
}

class ManpowerAddState extends ManpowerState {
  final String message;
  ManpowerAddState(this.message);
}
class ManpowerUpdateState extends ManpowerState {
  final String message;
  ManpowerUpdateState(this.message);
}

class ManpowerDeletedState extends ManpowerState{
  final String message;
  ManpowerDeletedState(this.message);
}

class SelectDateState extends ManpowerState {}


