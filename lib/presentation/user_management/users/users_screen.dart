import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/bloc/user_bloc.dart';
import 'package:hrm_bloc/presentation/user_management/users/bloc/user_state.dart';
import 'package:hrm_bloc/widgets/custom_loader.dart';
import 'bloc/user_event.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserBloc _userBloc = UserBloc();
  @override
  void initState() {
    _userBloc.add(UsersEventInitial());
    super.initState();
  }
 int select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_1_sharp))
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        floatingActionButton: _floatingButton(),
        body: BlocConsumer<UserBloc, UserState>(
          bloc: _userBloc,
          builder: (context, state) {
            if (state is UserStateLoading) {
              return const Center(
                child: CustomLoader(),
              );
            }
            if (state is UserStateLoaded) {
              var users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        select = index;
                      });
                    },
                    selectedTileColor: Colors.grey,
                    selected:select==index?true:false ,
                    title: Text(users[index]['name']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _userBloc.add(UsersEventDeleteUser(
                                users[index]['slug'].toString()));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (state is UserStateError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {
            if (state is UserStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is UserStateDeleted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/users', (route) => false);
            }
            if (state is UserAddNavigationState) {
              Navigator.pushNamed(context, '/add_user');
            }
          },
        ));
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        _userBloc.add(UserAddNavigationEvent());
      },
      child: const Icon(Icons.add),
    );
  }
}
