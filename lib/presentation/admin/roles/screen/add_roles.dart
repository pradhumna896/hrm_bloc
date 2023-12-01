import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/presentation/admin/roles/blocs/add_roles/add_roles_bloc.dart';
import 'package:hrm_bloc/presentation/admin/roles/blocs/roles/roles_bloc.dart';
import 'package:hrm_bloc/presentation/admin/roles/blocs/select_permission/select_permission_bloc.dart';

import '../../../../core/app_export.dart';
import '../../../../widgets/custom_checkbox.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/custom_text_field.dart';

class AddRoleScreen extends StatefulWidget {
  const AddRoleScreen({super.key});

  @override
  State<AddRoleScreen> createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  final AddRolesBloc _addRolesBloc = AddRolesBloc();
  final SelectPermissionBloc _selectPermissionBloc = SelectPermissionBloc();

  @override
  void initState() {
    _addRolesBloc.add(AddRolesInitialEvent());
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final roleController = TextEditingController();
  var permission;
  getData(context) {
    permission = ModalRoute.of(context)!.settings.arguments;
    roleController.text = permission.name!;
    _selectPermissionBloc.add(PermissionAddAll(
        permission.permissions!.map((e) => e.id.toString()).toList()));
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) getData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Role"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<AddRolesBloc, AddRolesState>(
          bloc: _addRolesBloc,
          listener: (context, state) {
            if (state is CreateRolesState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Role Created Successfully")));
              Navigator.pushNamedAndRemoveUntil(
                  context, "/roles", (route) => false);
            }
            if (state is UpdateRolesState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Role Updated Successfully")));
              Navigator.pushNamedAndRemoveUntil(
                  context, "/roles", (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AddRolesLoadingState) {
              return const Center(child: CustomLoader());
            }

            return BlocBuilder<SelectPermissionBloc, SelectPermissionState>(
                bloc: _selectPermissionBloc,
                builder: (context, stateSelect) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    color: Colors.white,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Expanded(
                              child: Stack(
                            children: [
                              Column(children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextFormField(
                                  controller: roleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter role name";
                                    } else if (value.length > 10) {}
                                    return null;
                                  },
                                  labelText: "Role Name",
                                  // controller: roleController.name.value,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                    child: Stack(
                                  children: [
                                    ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      itemCount:
                                          state is AddRolesListSuccessState
                                              ? state.rolesPermissionList.length
                                              : 0,
                                      itemBuilder: (context, index) {
                                        var group =
                                            state is AddRolesListSuccessState
                                                ? state
                                                    .rolesPermissionList[index]
                                                    .group
                                                : [];
                                        var data =
                                            state is AddRolesListSuccessState
                                                ? state
                                                    .rolesPermissionList[index]
                                                    .data as List<dynamic>
                                                : [];

                                        return Container(
                                          margin: EdgeInsets.only(bottom: 16.h),
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: const Offset(0,
                                                      1), // changes position of shadow
                                                )
                                              ]),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    group.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ListView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        if (stateSelect
                                                            is SelectPermissionInitial) {
                                                          return CustomCheckbox(
                                                            value: stateSelect
                                                                .addPermission
                                                                .contains(data[
                                                                        i]
                                                                    .id
                                                                    .toString()),
                                                            onChanged: (p0) {
                                                              if (stateSelect
                                                                  .addPermission
                                                                  .contains(data[
                                                                          i]
                                                                      .id
                                                                      .toString())) {
                                                                _selectPermissionBloc.add(
                                                                    PermissionRemove(
                                                                        data[i]
                                                                            .id
                                                                            .toString()));
                                                              } else {
                                                                _selectPermissionBloc.add(
                                                                    PermissionAddd(
                                                                        data[i]
                                                                            .id
                                                                            .toString()));
                                                              }
                                                            },
                                                            title: data[i].name,
                                                          );
                                                        } else {
                                                          return CustomCheckbox(
                                                            value: false,
                                                            onChanged: (p0) {
                                                              if (p0!) {
                                                                _selectPermissionBloc.add(
                                                                    PermissionAddd(
                                                                        data[i]
                                                                            .id
                                                                            .toString()));
                                                              } else {
                                                                _selectPermissionBloc.add(
                                                                    PermissionRemove(
                                                                        data[i]
                                                                            .id
                                                                            .toString()));
                                                              }
                                                            },
                                                            title: data[i].name,
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    // Positioned(
                                    //   top: 10,
                                    //   right: 10,
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       setState(() {
                                    //        permission.clear();
                                    //         if (!roleController.isCheck.value) {
                                    //           roleController.isCheck.value =
                                    //               !roleController.isCheck.value;
                                    //           roleController.permissionList
                                    //               // ignore: avoid_function_literals_in_foreach_calls
                                    //               .forEach((element) {
                                    //             var data = element["data"]
                                    //                 as List<dynamic>;
                                    //             // ignore: avoid_function_literals_in_foreach_calls
                                    //             data.forEach((element) {
                                    //               roleController.addPermissions
                                    //                   .add(element.id);
                                    //             });
                                    //           });
                                    //         } else {
                                    //           roleController.isCheck.value =
                                    //               !roleController.isCheck.value;
                                    //           roleController.addPermissions.clear();
                                    //         }
                                    //       });
                                    //     },
                                    //     child: Container(
                                    //       padding: const EdgeInsets.symmetric(
                                    //           horizontal: 15, vertical: 5),
                                    //       decoration: BoxDecoration(
                                    //           color: Colors.orange,
                                    //           borderRadius:
                                    //               BorderRadius.circular(15),
                                    //           boxShadow: [
                                    //             BoxShadow(
                                    //               color:
                                    //                   Colors.grey.withOpacity(0.5),
                                    //               spreadRadius: 1,
                                    //               blurRadius: 1,
                                    //               offset: const Offset(0,
                                    //                   1), // changes position of shadow
                                    //             )
                                    //           ]),
                                    //       child: Text(
                                    //         roleController.isCheck.value
                                    //             ? "All Unchecked"
                                    //             : "Check All",
                                    //         style: const TextStyle(
                                    //             color: Colors.white,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 16),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                )),
                                SizedBox(
                                  height: 60.h,
                                )
                              ]),
                              Positioned(
                                  bottom: 5,
                                  left: 0,
                                  right: 0,
                                  child: ElevatedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        permission == null
                                            ? _addRolesBloc.add(CreateRoleEvent(
                                                roleController.text,
                                                stateSelect
                                                        is SelectPermissionInitial
                                                    ? stateSelect.addPermission
                                                    : []))
                                            : _addRolesBloc.add(UpdateRoleEvent(
                                                roleController.text,
                                                stateSelect
                                                        is SelectPermissionInitial
                                                    ? stateSelect.addPermission
                                                    : [],
                                                permission.slug));
                                      }
                                    },
                                  ))
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
