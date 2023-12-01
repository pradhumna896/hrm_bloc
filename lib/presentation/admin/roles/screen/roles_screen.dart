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
    return Scaffold(
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
          listener: (context, state) {},
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
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addRole',
                              arguments: roles[index]);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    );
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
    );
  }
}
