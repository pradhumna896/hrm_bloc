import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_bloc.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_event.dart';

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
      body: BlocConsumer<ManpowerBloc, ManpowerState>(
          bloc: _manpowerBloc,
          listener: (context, state) {
            if (state is ManpowerDeletedState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/manpower", (route) => false);
            }
          },
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
                            arguments: manpower[index]);
                      },
                      leading: const CircleAvatar(),
                      title: Text(manpower[index].employee!.name!),
                      subtitle: Text(manpower[index].employee!.email!),
                      trailing: _buildPopUp(manpower, index),
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

  PopupMenuButton<String> _buildPopUp(List<ManpowerModel> manpower, int index) {
    return PopupMenuButton<String>(
      elevation: 5,
      surfaceTintColor: Colors.white,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == "edit") {
          Navigator.pushNamed(context, '/manpower_add',
              arguments: manpower[index]);  
        } else if (value == "delete") {
          _manpowerBloc.add(ManpowerDeleteEvent(manpower[index].id.toString()));
        }
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
