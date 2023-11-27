import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/board_screen.dart';
import 'package:hrm_bloc/presentation/auth/bloc/auth_bloc.dart';
import 'package:hrm_bloc/presentation/auth/login_screen.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/bloc/user_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/users_screen.dart';
import '../../core/constants/session_manager.dart';
import '../../presentation/home/home_page.dart';
import 'routes.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static List<PageEntity> routes() {
    return [
      PageEntity(
        path: AppRoutes.LOGIN,
        page: LoginScreen(),
        bloc: BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ),
      PageEntity(
        path: AppRoutes.HOME,
        page: HomePage(),
        bloc: BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ),
      PageEntity(
        path: AppRoutes.USERS,
        page: UsersScreen(),
        bloc: BlocProvider(
          create: (context) => UserBloc(),
        ),
      ),
      PageEntity(
        path: AppRoutes.BOARDS,
        page: BoardScreen(),
        bloc: BlocProvider(
          create: (context) => BoardBloc(),
        ),
      ),
    ];
  }

  static List<dynamic> blocer(BuildContext context) {
    List<dynamic> blocerList = <dynamic>[];
    for (var blocer in routes()) {
      blocerList.add(blocer.bloc);
    }
    return blocerList;
  }

  static MaterialPageRoute generateRouteSetting(RouteSettings settings) {
    if (settings.name != null) {
      print(settings.name);
      var result = routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) =>
            SessionManager.getToken() == null ? LoginScreen() : HomePage(),
        settings: settings);
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;
  PageEntity({required this.path, required this.page, this.bloc});
}