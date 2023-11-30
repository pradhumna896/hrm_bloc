import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_export.dart';
import '../../../../utils/time_formate_methode.dart';
import '../blocs/department/department_bloc.dart';
import '../blocs/department/department_event.dart';
import '../blocs/department/department_state.dart';

class DepartmentTileWidget extends StatelessWidget {
  final DepartmentBloc departmentBloc;
  final DepartmentListSuccessState state;
  final int index;
  DepartmentTileWidget({
    super.key,
    required this.state,
    required this.index,
    required this.departmentBloc,
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
                          Text(state.departmentList[index].name!,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(state.departmentList[index].description!,
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
                          Navigator.pushNamed(context, '/addDepartment',
                              arguments: state.departmentList[index]);
                        } else if (value == "delete") {
                          departmentBloc.add(DepartmentDeleteEvent(
                              state.departmentList[index].id.toString()));
                        } else if (value == "view") {
                          viewAlertDialog(context, () {}, () {},
                              state.departmentList[index]);
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
                color: state.departmentList[index].status == 1
                    ? Colors.red.withOpacity(0.5)
                    : Colors.green.withOpacity(0.5),
              ),
              child: Text(
                  state.departmentList[index].status == 1
                      ? "Inactive"
                      : "Active",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: state.departmentList[index].status == 1
                          ? Colors.red
                          : Colors.green,
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
                "Department View",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    fontFamily: "OpenSans"),
              ),
              SizedBox(height: 10.h),
              _buildTileWidget(title: "Name", value: data.name),
              SizedBox(height: 10.h),
              _buildTileWidget(title: "Description", value: data.description),
              SizedBox(height: 10.h),
              _buildTileWidget(title: "Created At", value:TimeFormateMethod().getTimeFormate(time:  data.createdAt.toString(),formate: 
              "dd-MM-yyyy hh:mm:a")),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // empDetails("Status", CustommTextStyle().normalTextBold),
                  SizedBox(width: 8.h),
                  Container(
                    height: 30.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: data.status == 0
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                    ),
                    child: Center(
                        child: Text(
                      data.status == 0 ? "Active" : "In-Active",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          color: data.status == 0 ? Colors.green : Colors.red),
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
      children: [
        empDetails(
            '$title :  ',
            TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold)),
        SizedBox(
          width: 140.h,
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
