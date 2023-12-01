import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'select_permission_event.dart';
part 'select_permission_state.dart';

class SelectPermissionBloc
    extends Bloc<SelectPermissionEvent, SelectPermissionState> {
  SelectPermissionBloc() : super(SelectPermissionInitial([])){
    // ignore: void_checks
    on<PermissionAddd>((event, emit) {
       List<String> upadateList = List.from((state as SelectPermissionInitial).addPermission);
    upadateList.add(event.id.toString());
     emit(SelectPermissionInitial(upadateList));
     print(upadateList);
    });
    // ignore: void_checks
    on<PermissionRemove>((event, emit){
        List<String> upadateList = List.from((state as SelectPermissionInitial).addPermission);
    upadateList.remove(event.id.toString());
     emit(SelectPermissionInitial(upadateList));
print(upadateList);
    });
  }

  Stream<SelectPermissionInitial> mapEventToState(
    SelectPermissionEvent event,
  ) async* {
   if(event is PermissionAddd){
   
   
  }else if(event is PermissionRemove ){
  
  }
  }

 
}
