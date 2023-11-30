import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/add_department/add_department_bloc.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/add_department/add_department_event.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/add_department/add_department_state.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_bloc.dart';
import 'package:hrm_bloc/utils/time_formate_methode.dart';
import 'package:hrm_bloc/widgets/custom_drodown.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../manpower/bloc/manpower_event.dart';
import '../blocs/add_project/add_project_bloc.dart';
import '../blocs/add_project/add_project_event.dart';
import '../blocs/add_project/add_project_state.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final AddProjectBloc _addProjectBloc = AddProjectBloc();
  final ManpowerBloc _manpowerBloc = ManpowerBloc();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateDateController = TextEditingController();
  String? status;
  String? type;
  var data;
  getData(context) {
    data = ModalRoute.of(context)!.settings.arguments;
    nameController.text = data.projectName;
    descriptionController.text = data.projectDescription;
    status = data.projectStatus;
    type = data.projectType;
    startDateController.text = data.startDate != null
        ? TimeFormateMethod().getTimeFormate(
            time: data.startDate.toString(), formate: "yyyy-MM-dd")
        : null;
    endDateDateController.text = data.endDate != null
        ? TimeFormateMethod().getTimeFormate(
            time: data.endDate.toString(), formate: "yyyy-MM-dd")
        : null;
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
        body: BlocConsumer<AddProjectBloc, AddProjectState>(
          bloc: _addProjectBloc,
          listener: (context, state) {
            if (state is CreateProjectState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Project Added Successfully"),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, '/project', (route) => false);
            }
            if (state is UpdateProjectState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Project Updated Successfully"),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, '/project', (route) => false);
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
                              hintText: "Enter Project Name",
                              labelText: "Project",
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
                              labelText: "Description",
                              hintText: "Enter Description",
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
                              labelText: "Project Type",
                              listName: const ["internal", "external"],
                              selectedItem: status,
                                
                              onChng: (value) {
                                type = value;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomDropdown(
                              labelText: "Project Status",
                              listName: const ["active", "inactive"],
                             selectedItem: type,
                              onChng: (value) {
                                status = value;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: CustomTextFormField(
                                    labelText: "Start Date",
                                    onTap: () {
                                      _manpowerBloc.add(SelectDateEvent(
                                          startDateController, context));
                                    },
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return "Please select ";
                                      }
                                      return null;
                                    },
                                    controller: startDateController,
                                    hintText: "Start Date",
                                    readOnly: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                SizedBox(
                                  width: 150.w,
                                  child: CustomTextFormField(
                                    labelText: "End Date",
                                    onTap: () {
                                      _manpowerBloc.add(SelectDateEvent(
                                          endDateDateController, context));
                                      print(endDateDateController.text);
                                    },
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return "Please select End Date";
                                      }
                                      return null;
                                    },
                                    controller: endDateDateController,
                                    hintText: "End Date",
                                    readOnly: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ElevatedButton(
                              child: Text("Submit"),
                              onPressed: () {
                                if (data != null) {
                                  _addProjectBloc.add(
                                    UpdateProjectEvent(
                                      id: data.id,
                                      startDate: startDateController.text, 
                                      endDate: endDateDateController.text,
                                      type: type,
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      status: status.toString(),
                                    ),
                                  );
                                } else {
                                  _addProjectBloc.add(
                                    CreateProjectEvent(
                                        name: nameController.text,
                                        description: descriptionController.text,
                                        status: status!,
                                        type: type!,
                                        startDate: startDateController.text,
                                        endDate: endDateDateController.text),
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
                if (state is ProjectLoadingState)
                  const Center(child: CustomLoader())
              ],
            );
          },
        ));
  }
}
