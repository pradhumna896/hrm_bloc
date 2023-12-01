import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/roles/blocs/roles/roles_bloc.dart';

import '../../../../widgets/custom_loader.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  final RolesBloc _rolesBloc = RolesBloc();
  @override
  void initState() {
    _rolesBloc.add(RolesInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Roles'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer<RolesBloc, RolesState>(
            bloc: _rolesBloc,
            listener: (context, state) {
              if (state is RoleDeleteSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                  duration: const Duration(seconds: 2),
                ));
                Navigator.pushNamedAndRemoveUntil(
                    context, "/roles", (route) => false);
              }
            },
            builder: (context, state) {
              if (state is RolesLoadingState) {
                return const Center(
                  child: CustomLoader(),
                );
              }
              if (state is RolesListSuccessState) {
                var roles = state.rolesList;
                return ListView.builder(
                    itemCount: roles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(roles[index].name!),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/addRole',
                                      arguments: roles[index]);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  _rolesBloc
                                      .add(RoleDeleteEvent(roles[index].slug!));
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ));
                    });
              }
              if (state is RolesListFailedState) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Container();
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addRole');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
