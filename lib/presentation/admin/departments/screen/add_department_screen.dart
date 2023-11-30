import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/add_department/add_department_bloc.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/add_department/add_department_event.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/add_department/add_department_state.dart';
import 'package:hrm_bloc/widgets/custom_drodown.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/custom_text_field.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({super.key});

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  final AddDepartmentBloc _addDepartmentBloc = AddDepartmentBloc();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int? status;
  var data;
  getData(context) {
    data = ModalRoute.of(context)!.settings.arguments;
    nameController.text = data.name;
    descriptionController.text = data.description;
    status = data.status;
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) getData(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Department'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer(
          bloc: _addDepartmentBloc,
          listener: (context, state) {
            if (state is CreateDepartmentState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Department Added Successfully"),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, '/department', (route) => false);
            }
            if (state is UpdateDepartmentState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Department Updated Successfully"),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, '/department', (route) => false);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomTextFormField(
                              controller: nameController,
                              labelText: "Enter Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomTextFormField(
                              controller: descriptionController,
                              labelText: "Enter Description",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Description";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomDropdown(
                              labelText: "Status",
                              listName: const ["Active", "Inactive"],
                              selectedItem: data != null
                                  ? status == 0
                                      ? "Active"
                                      : "Inactive"
                                  : null,
                              onChng: (value) {
                                if (value == "Active") {
                                  status = 0;
                                } else {
                                  status = 1;
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ElevatedButton(
                              child: Text("Submit"),
                              onPressed: () {
                                if (data != null) {
                                  _addDepartmentBloc.add(
                                    UpdateDepartmentEvent(
                                      id: data.id,
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      status: status.toString(),
                                    ),
                                  );
                                } else {
                                  _addDepartmentBloc.add(
                                    CreateDepartmentEvent(
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      status: status.toString(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is DepartmentLoadingState)
                  const Center(child: CustomLoader())
              ],
            );
          },
        ));
  }
}
