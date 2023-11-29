import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_bloc.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_event.dart';
import 'package:hrm_bloc/presentation/admin/manpower/model/Employee_model.dart';
import 'package:hrm_bloc/presentation/admin/manpower/model/manpower_model.dart';

import '../../../widgets/custom_loader.dart';
import 'bloc/manpower_state.dart';

class ManpowerScreen extends StatefulWidget {
  const ManpowerScreen({super.key});

  @override
  State<ManpowerScreen> createState() => _ManpowerScreenState();
}

class _ManpowerScreenState extends State<ManpowerScreen> {
  ManpowerBloc _manpowerBloc = ManpowerBloc();
  @override
  void initState() {
    _manpowerBloc.add(ManpowerInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manpower'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.filter))],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<ManpowerBloc, ManpowerState>(
          bloc: _manpowerBloc,
          builder: (context, state) {
            if (state is GetManpowerLoading) {
              return const Center(
                child: CustomLoader(),
              );
            }
            if (state is GetManpowerListSuccess) {
              var manpower = state.manpowerList;
              return ListView.builder(
                  itemCount: manpower.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/employee-detail',
                            arguments: EmployeeModel(
                              id: manpower[index].id.toString(),
                              name: manpower[index].employee!.name,
                              email: manpower[index].employee!.email,
                              phone: manpower[index].employee!.phone,
                              role: manpower[index].employee!.role,
                              gender: manpower[index].gender,
                              material: manpower[index].maritalStatus,
                              department: manpower[index].department!.name,
                            ));
                      },
                      leading: const CircleAvatar(),
                      title: Text(manpower[index].employee!.name!),
                      subtitle: Text(manpower[index].employee!.email!),
                      trailing: const _buildPopUp(),
                    ));
                  });
            }
            if (state is GetManpowerListFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/manpower_add');
        },
      ),
    );
  }
}

class _buildPopUp extends StatelessWidget {
  const _buildPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 5,
      surfaceTintColor: Colors.white,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == "edit") {
        } else if (value == "delete") {}
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.visibility),
                SizedBox(
                  width: 10.w,
                ),
                const Text("View"),
              ],
            ),
            value: "edit",
          ),
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.edit),
                SizedBox(
                  width: 10.w,
                ),
                const Text("Edit"),
              ],
            ),
            value: "edit",
          ),
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.delete),
                SizedBox(
                  width: 10.w,
                ),
                const Text("Delete"),
              ],
            ),
            value: "delete",
          ),
        ];
      },
    );
  }
}
