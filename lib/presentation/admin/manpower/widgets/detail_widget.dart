import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_export.dart';

class DetailWidget extends StatelessWidget {
  final users;
  const DetailWidget({super.key, this.users});

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
            users.employee.role,
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
            _buildLabel("Name", users.employee.name),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Email", users.employee.email),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Phone", users.employee.phone),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Role", users.employee.role),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Department",
                users.department != null ? users.department.name : "N/A"),
            SizedBox(
              height: 5.h,
            ),
            _buildLabel("Material", users.maritalStatus)
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
