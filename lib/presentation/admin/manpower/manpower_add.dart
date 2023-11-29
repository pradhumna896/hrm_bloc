import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/blocs/department_dropdown/dept_dropdown_bloc.dart';
import 'package:hrm_bloc/blocs/department_dropdown/dept_dropdown_event.dart';
import 'package:hrm_bloc/blocs/department_dropdown/dept_dropdown_state.dart';
import 'package:hrm_bloc/blocs/role_dropdown/role_dropdown_bloc.dart';
import 'package:hrm_bloc/blocs/role_dropdown/role_dropdown_event.dart';
import 'package:hrm_bloc/blocs/role_dropdown/role_dropdown_state.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_bloc.dart';
import 'package:hrm_bloc/presentation/admin/manpower/bloc/manpower_event.dart';
import 'package:hrm_bloc/widgets/custom_drodown.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/custom_text_field.dart';
import 'bloc/manpower_state.dart';

class ManpowerAdd extends StatefulWidget {
  const ManpowerAdd({super.key});

  @override
  State<ManpowerAdd> createState() => _ManpowerAddState();
}

class _ManpowerAddState extends State<ManpowerAdd> {
  final ManpowerBloc _manpowerBloc = ManpowerBloc();
  final DeptDropdownBloc _deptDropdownBloc = DeptDropdownBloc();
  final RoleDropdownBloc _roleDropdownBloc = RoleDropdownBloc();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyNumberController =
      TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController branchAddressController = TextEditingController();
  final TextEditingController branchCityController = TextEditingController();
  final TextEditingController bankAccountNameController =
      TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController leaveBalanceController = TextEditingController();
  final TextEditingController probationPeriodController =
      TextEditingController();
  final TextEditingController benifitController = TextEditingController();
  final TextEditingController dateOfController = TextEditingController();
  String role = "";
  final _formKey = GlobalKey<FormState>();
  String gender = "Male";
  @override
  void initState() {
    _deptDropdownBloc.add(DeptDropdownInitialEvent());
    _roleDropdownBloc.add(RoleDropdownInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Manpower'),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/manpower', (route) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer<ManpowerBloc, ManpowerState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetManpowerListFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              return BlocBuilder<RoleDropdownBloc, RoleDropdownState>(
                  bloc: _roleDropdownBloc,
                  builder: (context, stateRole) {
                    return BlocBuilder<DeptDropdownBloc, DeptDropdownState>(
                        bloc: _deptDropdownBloc,
                        builder: (context, stateDepartment) {
                          return _buildFormWidget(
                              stateRole, stateDepartment, state);
                        });
                  });
            }));
  }

  Stack _buildFormWidget(RoleDropdownState stateRole,
      DeptDropdownState stateDepartment, ManpowerState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Personal Details",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: 'Name',
                                controller: nameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: 'Email',
                                controller: emailController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: 'Phone',
                                controller: phoneController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: 'Emergency Number',
                                controller: emergencyNumberController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdown(
                                labelText: "Roles",
                                listName: stateRole is RoleDropdownLoadedState
                                    ? stateRole.roles
                                        .map((e) => e['name'].toString())
                                        .toList()
                                    : [],
                                onChng: (value) {
                                  for (var ele
                                      in stateRole is RoleDropdownLoadedState
                                          ? stateRole.roles
                                          : []) {
                                    if (ele['id'] == value) {
                                      role = ele['id'].toString();
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdown(
                                labelText: "Department",
                                listName:
                                    stateDepartment is DeptDropdownLoadedState
                                        ? stateDepartment.departments
                                            .map((e) => e['name'].toString())
                                            .toList()
                                        : [],
                                onChng: (value) {
                                  for (var ele in stateDepartment
                                          is DeptDropdownLoadedState
                                      ? stateDepartment.departments
                                      : []) {
                                    if (ele['id'] == value) {
                                      role = ele['id'].toString();
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdown(
                                  labelText: "Material Status", listName: []),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdown(
                                  labelText: "Employee Type", listName: []),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdown(
                                  labelText: "Employee Status", listName: []),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: "Designation",
                                controller: designationController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Gender :",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Male"),
                                    value: "male",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Female"),
                                    value: "female",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              // joining date pickker

                              CustomTextFormField(
                                  labelText: "Date Of Birth",
                                  controller: dateOfController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Joining Date",
                                  controller: joiningDateController),
                              SizedBox(
                                height: 10.h,
                              ),

                              Text(
                                "Address Details",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "City",
                                  controller: cityController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "State",
                                  controller: stateController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Country",
                                  controller: countryController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Pincode",
                                  controller: pincodeController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Address",
                                  controller: addressController),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Banking Details",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Bank Name",
                                  controller: bankNameController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Bank Account Name",
                                  controller: bankAccountNameController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Account Number",
                                  controller: accountNumberController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "IFSC Code",
                                  controller: ifscCodeController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Branch Name",
                                  controller: branchNameController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Branch City",
                                  controller: branchCityController),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Other Details",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                  labelText: "Salary",
                                  controller: salaryController),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: "Rating",
                                controller: ratingController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: "Leave Balance",
                                controller: leaveBalanceController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: "Probation Period",
                                controller: probationPeriodController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                labelText: "Benifit",
                                controller: benifitController,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 44.h),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    _manpowerBloc.add(ManpowerAddEvent(
                                        name: nameController.text,
                                        email: emailController.text,
                                        role: "admin",
                                        department: "It",
                                        dateOfBirth: dateOfController.text));
                                  },
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ]),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (state is GetManpowerLoading ||
            stateRole is RoleDropdownLoadingState ||
            stateDepartment is DeptDropdownLoadingState)
          const Center(
            child: CustomLoader(),
          ),
      ],
    );
  }
}
