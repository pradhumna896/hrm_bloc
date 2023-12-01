import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_bloc.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_event.dart';
import 'package:hrm_bloc/presentation/home/bloc/home_state.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Home Page'),
            leading: IconButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(OpenDrawerEvent());
              },
              icon: const Icon(Icons.menu),
            ),
          ),
          drawer: _buildDrawer(context),
        );
      },
      listener: (context, state) {
        if (state is HomeStateOpenDrawer) {
          scaffoldKey.currentState!.openDrawer();
        }
        if (state is UserNavigationState) {
          Navigator.pushNamed(context, '/users');
        }
        if (state is BoardNavigationState) {
          Navigator.pushNamed(context, '/boards');
        }
      },
    );
  }

// Open Drawer
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Users'),
            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(UserNavigationEvent());
            },
          ),
          ListTile(
            title: const Text('Board'),
            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(BoardNavigationEvent());
            },
          ),
          ListTile(
            title: const Text('manpower'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/manpower',
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('department'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/department',
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Project'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/project',
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Roles'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/roles',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
