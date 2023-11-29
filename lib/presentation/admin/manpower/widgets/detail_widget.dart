import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_export.dart';
import '../model/Employee_model.dart';

class DetailWidget extends StatelessWidget {
  final EmployeeModel users;
  const DetailWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, right: 15.h, left: 15.h),
      decoration: const BoxDecoration(),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const CircleAvatar(
          radius: 75,
        ),
        Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 2), blurRadius: 10)
              ]),
          child: Text(
            users.role.toString(),
            style: TextStyle(
                color: Colors.green,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Details",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            _buildLabel("Name", users.name),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Email", users.email),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Phone", users.phone),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Role", users.role),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Department", users.department),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Material", users.material)
          ],
        )
      ]),
    );
  }

  Row _buildLabel(label, title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label :",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black54),
        ),
      ],
    );
  }
}