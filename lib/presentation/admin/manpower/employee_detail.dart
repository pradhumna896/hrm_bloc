import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/manpower/model/Employee_model.dart';
import 'package:hrm_bloc/presentation/admin/manpower/widgets/detail_widget.dart';

class EmployeeDetail extends StatefulWidget {
  const EmployeeDetail({super.key});

  @override
  State<EmployeeDetail> createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  @override
  Widget build(BuildContext context) {
    var users = ModalRoute.of(context)!.settings.arguments as EmployeeModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Detail'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(children: [
        DetailWidget(users: users),
        Column(
          children: [
            _buildTabOption(() {}, "Task"),
            _buildTabOption(() {}, "Project"),
            _buildTabOption(() {}, "Attendance"),
          ],
        )
      ]),
    );
  }

  _buildTabOption(void Function()? onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: 0.07.sh,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
