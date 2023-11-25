import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/auth/bloc/auth_bloc.dart';
import 'package:hrm_bloc/presentation/auth/login_screen.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/bloc/user_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/users_screen.dart';
import 'package:hrm_bloc/routes/routes.dart';
import '../presentation/home/home_page.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static List<PageEntity> routes() {
    return [
      PageEntity(
        path: AppRoutes.login,
        page: LoginScreen(),
        bloc: BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ),
      PageEntity(
        path: AppRoutes.home,
        page: HomePage(),
        bloc: BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ),
      PageEntity(
        path: AppRoutes.users,
        page: UsersScreen(),
        bloc: BlocProvider(
          create: (context) => UserBloc(),
        ),
      )
    ];
  }
  static List<dynamic> blocer(BuildContext context){
    List<dynamic> blocerList = <dynamic>[];
    for(var blocer in routes()){
      blocerList.add(blocer.bloc);
    }
    return blocerList;
  }

  // static MaterialPageRoute generateRouteSetting(RouteSettings settings){
  //   if(settings.name!=null){
  //     var result = routes().where((element) => element.path==settings.name);
  //     if(result.isNotEmpty){
  //       bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
  //       if(result.first.path==AppRoutes.login && deviceFirstOpen){
  //         bool isLogin = Global.storageService.getIsLogin();
  //         if(isLogin){

  //         }
  //       }
  //     }
  //   }
  // }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;
  PageEntity({required this.path, required this.page, this.bloc});
}
