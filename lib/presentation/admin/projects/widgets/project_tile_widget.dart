import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/presentation/admin/projects/blocs/project/project_bloc.dart';
import 'package:hrm_bloc/presentation/admin/projects/blocs/project/project_event.dart';
import '../../../../core/app_export.dart';
import '../../../../utils/time_formate_methode.dart';
import '../blocs/project/project_bloc.dart';
import '../blocs/project/project_state.dart';

class ProjectTileWidget extends StatelessWidget {
  final ProjectBloc projectBloc;
  final ProjectListSuccessState state;
  final int index;
  ProjectTileWidget({
    super.key,
    required this.state,
    required this.index,
    required this.projectBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
        top: 10.h,
      ),
      child: Card(
        elevation: 3,
        surfaceTintColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.ProjectList[index].projectName!,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(state.ProjectList[index].projectDescription!,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87)),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) {
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
                            value: "view",
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
                      onSelected: (value) {
                        if (value == "edit") {
                          Navigator.pushNamed(context, '/addProject',
                              arguments: state.ProjectList[index]);
                        } else if (value == "delete") {
                          projectBloc.add(ProjectDeleteEvent(
                              state.ProjectList[index].id.toString()));
                        } else if (value == "view") {
                          viewAlertDialog(
                              context, () {}, () {}, state.ProjectList[index]);
                        }
                      },
                    ),
                  ],
                )),
            Divider(),
            Container(
              margin: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: state.ProjectList[index].projectStatus == "active"
                    ? Colors.green.withOpacity(0.5)
                    : Colors.red.withOpacity(0.5),
              ),
              child: Text(
                  state.ProjectList[index].projectStatus == 'active'
                      ? "Active"
                      : "Inactive",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: state.ProjectList[index].projectStatus == "active"
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  void viewAlertDialog(
      context, VoidCallback noTap, VoidCallback deleteTap, data,
      {title, msg}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Project View",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    fontFamily: "OpenSans"),
              ),
              SizedBox(height: 10.h),
              _buildTileWidget(title: "Name", value: data.projectName),
              SizedBox(height: 10.h),
              _buildTileWidget(
                  title: "Description", value: data.projectDescription),
              SizedBox(height: 10.h),
              _buildTileWidget(
                  title: "Start Date",
                  value: TimeFormateMethod().getTimeFormate(
                      time: data.startDate.toString(), formate: "dd-MM-yyyy")),
              SizedBox(height: 10.h),
              _buildTileWidget(
                  title: "End Date",
                  value: data.endDate != null
                      ? TimeFormateMethod().getTimeFormate(
                          time: data.endDate.toString(), formate: "dd-MM-yyyy")
                      : null),
              SizedBox(height: 10.h),
              _buildTileWidget(title: "Project Type", value: data.projectType),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  empDetails(
                      "Project Status",
                      TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 8.h),
                  Container(
                    height: 30.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: data.projectStatus == "active"
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                    ),
                    child: Center(
                        child: Text(
                      data.projectStatus == "active" ? "Active" : "In-Active",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          color: data.projectStatus == "active"
                              ? Colors.green
                              : Colors.red),
                    )),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Row _buildTileWidget({title, value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        empDetails(
            '$title :  ',
            TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold)),
        SizedBox(
          width: 140.w,
          child: empDetails(
              value == null ? "N/A" : value.toString(),
              TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  empDetails(String text, TextStyle style) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: style,
    );
  }
}
