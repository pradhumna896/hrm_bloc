import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/add_board_screen.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/board_screen.dart';
import 'package:hrm_bloc/presentation/auth/bloc/auth_bloc.dart';
import 'package:hrm_bloc/presentation/auth/login_screen.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_bloc.dart';
import 'package:hrm_bloc/presentation/home/home_page.dart';
import 'package:hrm_bloc/presentation/user_management/users/add_user.dart';
import 'package:hrm_bloc/presentation/user_management/users/bloc/user_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/users_screen.dart';

import 'core/constants/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
        BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
        BlocProvider<BoardBloc>(create: (_) => BoardBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        initialRoute: SessionManager.getToken() == null ?'/login' : '/home',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomePage(),
          "/users": (context) => UsersScreen(),
          "/add_user": (context) => AddUserScreen(),
          "/board": (context) => BoardScreen(),
          "/add_board": (context) => AddBoardScreen(),

        },
      ),
    );
  }
}
