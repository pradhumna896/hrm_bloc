import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_event.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc() : super(HomeStateInitial()){
    on<OpenDrawerEvent>((event, emit) async {
      emit(HomeStateOpenDrawer());
    });
    on<UserNavigationEvent>((event, emit) async {
      emit(UserNavigationState());
    });
    on<BoardNavigationEvent>((event, emit) async {
      emit(BoardNavigationState());
    });
  }
}