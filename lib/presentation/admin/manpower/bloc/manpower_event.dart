abstract class ManpowerEvent {}

class ManpowerInitialEvent extends ManpowerEvent {
  final String? search;
  ManpowerInitialEvent({this.search});
}

class ManpowerTrigerEvent extends ManpowerEvent {
  final int index;
  ManpowerTrigerEvent(this.index);
}



class ManpowerAddEvent extends ManpowerEvent {
  final String name;
  final String email;
  final String? phone;
  final String? emergencyNumber;
  final String role;
  final String department;
  final String? material;
  final String? employeeType;
  final String? employeeStatus;
  final String? designation;
  final String? gender;
  final String dateOfBirth;
  final String? joinOfDate;
  final String? city;
  final String? state;
  final String? country;
  final String? pincode;
  final String? address;
  final String? bankName;
  final String? bankAccountName;
  final String? accountNumber;
  final String? ifscCode;
  final String? branchName;
  final String? branchCity;
  final String? salary;
  final String? rating;
  final String? leaveBalance;
  final String? probationPeriod;
  final String? benifit;
  ManpowerAddEvent({
    required this.name,
    required this.email,
    this.phone,
    this.emergencyNumber,
    required this.role,
    required this.department,
    this.material,
    this.employeeType,
    this.employeeStatus,
    this.designation,
    this.gender,
    required this.dateOfBirth,
    this.joinOfDate,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.address,
    this.bankName,
    this.bankAccountName,
    this.accountNumber,
    this.ifscCode,
    this.branchName,
    this.branchCity,
    this.salary,
    this.rating,
    this.leaveBalance,
    this.probationPeriod,
    this.benifit,
  });
}
