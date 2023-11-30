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
import 'package:hrm_bloc/utils/time_formate_methode.dart';
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
  String? role;
  String? slug;
  String? departmentID;
  String? materialStatus;
  String? employeeType;
  String? employeeStatus;
  String? gender;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _deptDropdownBloc.add(DeptDropdownInitialEvent());
    _roleDropdownBloc.add(RoleDropdownInitialEvent());
    super.initState();
  }

  var data;
  getData(context) {
    data = ModalRoute.of(context)!.settings.arguments;
    nameController.text = data.employee.name;
    emailController.text = data.employee.email;
    phoneController.text = data.employee.phone;
    emergencyNumberController.text = data.emergencyNumber;
    designationController.text = data.designation;
    salaryController.text = data.salary;
    joiningDateController.text = data.dateOfJoining;
    addressController.text = data.address;
    cityController.text = data.city ?? "";
    stateController.text = data.state ?? "";
    countryController.text = data.country ?? "";
    pincodeController.text = data.pincode ?? "";
    bankNameController.text = data.bankName ?? "";
    accountNumberController.text = data.bankAccountNumber ?? "";
    ifscCodeController.text = data.bankIfscCode ?? "";
    branchNameController.text = data.bankBranch ?? "";
    branchCityController.text = data.bankCity ?? "";
    bankAccountNameController.text = data.bankAccountName ?? "";
    ratingController.text = data.rating ?? "";
    leaveBalanceController.text = data.leaveBalance ?? "";
    probationPeriodController.text = data.probabationPeriod ?? "";
    benifitController.text = data.benifits ?? "";
    dateOfController.text = TimeFormateMethod().getTimeFormate(
            time: data.dateOfBirth.toString(), formate: "yyyy-MM-dd") ??
        "";
    joiningDateController.text = TimeFormateMethod().getTimeFormate(
            time: data.dateOfJoining.toString(), formate: "yyyy-MM-dd") ??
        "";
    role = data.employee.role ?? "";

    departmentID = data.departmentId.toString();
    materialStatus = data.maritalStatus.toString();
    employeeType = data.employeeType.toString();
    employeeStatus = data.employeeStatus ?? "";
    gender = data.gender ?? "";
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) getData(context);
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
            bloc: _manpowerBloc,
            listener: (context, state) {
              if (state is ManpowerAddState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message)));
                Navigator.pushNamedAndRemoveUntil(
                    context, '/manpower', (route) => false);
              }
              if (state is ManpowerUpdateState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message)));
                Navigator.pushNamedAndRemoveUntil(
                    context, '/manpower', (route) => false);
              }
            },
            builder: (context, state) {
              if (state is GetManpowerListFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              return BlocBuilder<RoleDropdownBloc, RoleDropdownState>(
                  bloc: _roleDropdownBloc,
                  builder: (context, stateRole) {
                    return BlocBuilder<DeptDropdownBloc, DeptDropdownState>(
                        bloc: _deptDropdownBloc,
                        builder: (context, stateDepartment) {
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Personal Details",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText: 'Name',
                                                      controller:
                                                          nameController,
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
                                                      controller:
                                                          emailController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText: 'Phone',
                                                      controller:
                                                          phoneController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText:
                                                          'Emergency Number',
                                                      controller:
                                                          emergencyNumberController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomDropdown(
                                                      labelText: "Roles",
                                                      selectedItem: data != null
                                                          ? data.employee.role
                                                          : null,
                                                      listName: stateRole
                                                              is RoleDropdownLoadedState
                                                          ? stateRole.roles
                                                              .map((e) => e[
                                                                      'name']
                                                                  .toString())
                                                              .toList()
                                                          : [],
                                                      onChng: (value) {
                                                        for (var ele in stateRole
                                                                is RoleDropdownLoadedState
                                                            ? stateRole.roles
                                                            : []) {
                                                          if (ele['name'] ==
                                                              value) {
                                                            print(value);

                                                            role = ele['slug']
                                                                .toString();
                                                            print(role);
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomDropdown(
                                                      labelText: "Department",
                                                      selectedItem: data != null
                                                          ? data.department.name
                                                          : null,
                                                      listName: stateDepartment
                                                              is DeptDropdownLoadedState
                                                          ? stateDepartment
                                                              .departments
                                                              .map((e) => e[
                                                                      'name']
                                                                  .toString())
                                                              .toList()
                                                          : [],
                                                      onChng: (value) {
                                                        for (var ele
                                                            in stateDepartment
                                                                    is DeptDropdownLoadedState
                                                                ? stateDepartment
                                                                    .departments
                                                                : []) {
                                                          if (ele['name'] ==
                                                              value) {
                                                            departmentID =
                                                                ele['id']
                                                                    .toString();
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomDropdown(
                                                        labelText:
                                                            "Material Status",
                                                        selectedItem: data !=
                                                                null
                                                            ? data.maritalStatus
                                                            : null,
                                                        listName: const [
                                                          "married",
                                                          "unmarried"
                                                        ],
                                                        onChng: (value) {
                                                          for (var ele
                                                              in const [
                                                            "married",
                                                            "unmarried"
                                                          ]) {
                                                            if (ele == value) {
                                                              print(ele);
                                                              materialStatus =
                                                                  ele;
                                                            }
                                                          }
                                                        }),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomDropdown(
                                                        selectedItem: data !=
                                                                null
                                                            ? data.employeeType
                                                            : null,
                                                        labelText:
                                                            "Employee Type",
                                                        listName: const [
                                                          "Permanent",
                                                          "Contract"
                                                        ],
                                                        onChng: (value) {
                                                          for (var ele
                                                              in const [
                                                            "Permanent",
                                                            "Contract"
                                                          ]) {
                                                            if (ele == value) {
                                                              materialStatus =
                                                                  ele;
                                                            }
                                                          }
                                                        }),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomDropdown(
                                                        selectedItem: data !=
                                                                null
                                                            ? data
                                                                .employeeStatus
                                                            : null,
                                                        labelText:
                                                            "Employee Status",
                                                        listName: const [
                                                          "Reguler",
                                                          "Probation",
                                                          "Terminated",
                                                        ],
                                                        onChng: (value) {
                                                          for (var ele
                                                              in const [
                                                            "Reguler",
                                                            "Probation",
                                                            "Terminated",
                                                          ]) {
                                                            if (ele == value) {
                                                              employeeStatus =
                                                                  ele;
                                                            }
                                                          }
                                                        }),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText: "Designation",
                                                      controller:
                                                          designationController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),

                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Gender :",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        RadioListTile(
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          title: Text("Male"),
                                                          value: "male",
                                                          groupValue: gender,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              gender = value
                                                                  .toString();
                                                            });
                                                          },
                                                        ),
                                                        RadioListTile(
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          title: Text("Female"),
                                                          value: "female",
                                                          groupValue: gender,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              gender = value
                                                                  .toString();
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    // joining date pickker

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 160.w,
                                                          child:
                                                              CustomTextFormField(
                                                            labelText:
                                                                "Select DOB",
                                                            onTap: () {
                                                              _manpowerBloc.add(
                                                                  SelectDateEvent(
                                                                      dateOfController,
                                                                      context));
                                                            },
                                                            validator: (p0) {
                                                              if (p0!.isEmpty) {
                                                                return "Please select Dob";
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                dateOfController,
                                                            hintText:
                                                                "Select DOB",
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.h,
                                                        ),
                                                        SizedBox(
                                                          width: 160.w,
                                                          child:
                                                              CustomTextFormField(
                                                            labelText:
                                                                "Select Join Date",
                                                            onTap: () {
                                                              _manpowerBloc.add(
                                                                  SelectDateEvent(
                                                                      joiningDateController,
                                                                      context));
                                                            },
                                                            validator: (p0) {
                                                              if (p0!.isEmpty) {
                                                                return "Please select Date of joining";
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                joiningDateController,
                                                            hintText:
                                                                "Select Date of joining",
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),

                                                    Text(
                                                      "Address Details",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "City",
                                                        controller:
                                                            cityController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "State",
                                                        controller:
                                                            stateController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "Country",
                                                        controller:
                                                            countryController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "Pincode",
                                                        controller:
                                                            pincodeController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "Address",
                                                        controller:
                                                            addressController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      "Banking Details",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "Bank Name",
                                                        controller:
                                                            bankNameController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText:
                                                            "Bank Account Name",
                                                        controller:
                                                            bankAccountNameController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText:
                                                            "Account Number",
                                                        controller:
                                                            accountNumberController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "IFSC Code",
                                                        controller:
                                                            ifscCodeController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText:
                                                            "Branch Name",
                                                        controller:
                                                            branchNameController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText:
                                                            "Branch City",
                                                        controller:
                                                            branchCityController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      "Other Details",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                        labelText: "Salary",
                                                        controller:
                                                            salaryController),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText: "Rating",
                                                      controller:
                                                          ratingController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText:
                                                          "Leave Balance",
                                                      controller:
                                                          leaveBalanceController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText:
                                                          "Probation Period",
                                                      controller:
                                                          probationPeriodController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    CustomTextFormField(
                                                      labelText: "Benifit",
                                                      controller:
                                                          benifitController,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            minimumSize: Size(
                                                                double.infinity,
                                                                44.h),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                        onPressed: () {
                                                          data != null
                                                              ? _manpowerBloc.add(
                                                                  ManpowerUpdateEvent(
                                                                  id: data.id,
                                                                  designation:
                                                                      designationController
                                                                          .text,
                                                                  emergencyNumber:
                                                                      emergencyNumberController
                                                                          .text,
                                                                  employeeStatus:
                                                                      employeeStatus,
                                                                  employeeType:
                                                                      employeeType,
                                                                  gender:
                                                                      gender,
                                                                  joinOfDate:
                                                                      joiningDateController
                                                                          .text,
                                                                  material:
                                                                      materialStatus,
                                                                  name:
                                                                      nameController
                                                                          .text,
                                                                  email:
                                                                      emailController
                                                                          .text,
                                                                  role: role ??
                                                                      "",
                                                                  department:
                                                                      departmentID ??
                                                                          "",
                                                                  dateOfBirth:
                                                                      dateOfController
                                                                          .text,
                                                                  address:
                                                                      addressController
                                                                          .text,
                                                                  city:
                                                                      cityController
                                                                          .text,
                                                                  state:
                                                                      stateController
                                                                          .text,
                                                                  country:
                                                                      countryController
                                                                          .text,
                                                                  pincode:
                                                                      pincodeController
                                                                          .text,
                                                                  bankName:
                                                                      bankNameController
                                                                          .text,
                                                                  bankAccountName:
                                                                      bankAccountNameController
                                                                          .text,
                                                                  accountNumber:
                                                                      accountNumberController
                                                                          .text,
                                                                  ifscCode:
                                                                      ifscCodeController
                                                                          .text,
                                                                  branchName:
                                                                      branchNameController
                                                                          .text,
                                                                  branchCity:
                                                                      branchCityController
                                                                          .text,
                                                                  salary:
                                                                      salaryController
                                                                          .text,
                                                                  rating:
                                                                      ratingController
                                                                          .text,
                                                                  leaveBalance:
                                                                      leaveBalanceController
                                                                          .text,
                                                                  probationPeriod:
                                                                      probationPeriodController
                                                                          .text,
                                                                  benifit:
                                                                      benifitController
                                                                          .text,
                                                                  phone:
                                                                      phoneController
                                                                          .text,
                                                                ))
                                                              : _manpowerBloc.add(
                                                                  ManpowerAddEvent(
                                                                  designation:
                                                                      designationController
                                                                          .text,
                                                                  emergencyNumber:
                                                                      emergencyNumberController
                                                                          .text,
                                                                  employeeStatus:
                                                                      employeeStatus,
                                                                  employeeType:
                                                                      employeeType,
                                                                  gender:
                                                                      gender,
                                                                  joinOfDate:
                                                                      joiningDateController
                                                                          .text,
                                                                  material:
                                                                      materialStatus,
                                                                  name:
                                                                      nameController
                                                                          .text,
                                                                  email:
                                                                      emailController
                                                                          .text,
                                                                  role: role ??
                                                                      "",
                                                                  department:
                                                                      departmentID ??
                                                                          "",
                                                                  dateOfBirth:
                                                                      dateOfController
                                                                          .text,
                                                                  address:
                                                                      addressController
                                                                          .text,
                                                                  city:
                                                                      cityController
                                                                          .text,
                                                                  state:
                                                                      stateController
                                                                          .text,
                                                                  country:
                                                                      countryController
                                                                          .text,
                                                                  pincode:
                                                                      pincodeController
                                                                          .text,
                                                                  bankName:
                                                                      bankNameController
                                                                          .text,
                                                                  bankAccountName:
                                                                      bankAccountNameController
                                                                          .text,
                                                                  accountNumber:
                                                                      accountNumberController
                                                                          .text,
                                                                  ifscCode:
                                                                      ifscCodeController
                                                                          .text,
                                                                  branchName:
                                                                      branchNameController
                                                                          .text,
                                                                  branchCity:
                                                                      branchCityController
                                                                          .text,
                                                                  salary:
                                                                      salaryController
                                                                          .text,
                                                                  rating:
                                                                      ratingController
                                                                          .text,
                                                                  leaveBalance:
                                                                      leaveBalanceController
                                                                          .text,
                                                                  probationPeriod:
                                                                      probationPeriodController
                                                                          .text,
                                                                  benifit:
                                                                      benifitController
                                                                          .text,
                                                                  phone:
                                                                      phoneController
                                                                          .text,
                                                                ));
                                                        },
                                                        child: Text(
                                                          "Submit",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                  stateDepartment is DeptDropdownLoadingState ||
                                  stateRole is RoleDropdownLoadingState)
                                const Center(
                                  child: CustomLoader(),
                                ),
                            ],
                          );
                        });
                  });
            }));
  }
}
