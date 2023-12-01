// To parse this JSON data, do
//
//     final manpowerModel = manpowerModelFromJson(jsonString);

import 'dart:convert';

List<ManpowerModel> manpowerModelFromJson(String str) =>
    List<ManpowerModel>.from(
        json.decode(str).map((x) => ManpowerModel.fromJson(x)));

String manpowerModelToJson(List<ManpowerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManpowerModel {
  final int? id;
  final dynamic profilePicture;
  final DateTime? dateOfBirth;
  final dynamic dateOfJoining;
  final String? gender;
  final String? maritalStatus;
  final String? address;
  final dynamic city;
  final dynamic state;
  final dynamic country;
  final dynamic pincode;
  final int? employeeId;
  final int? departmentId;
  final String? designation;
  final dynamic employeeType;
  final String? employeeStatus;
  final String? salary;
  final dynamic bankName;
  final dynamic bankAccountName;
  final dynamic bankAccountNumber;
  final dynamic bankIfscCode;
  final dynamic bankBranch;
  final dynamic bankCity;
  final dynamic rating;
  final dynamic leaveBalance;
  final String? emergencyNumber;
  final dynamic benifits;
  final String? probabationPeriod;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Department? department;
  final Employee? employee;

  ManpowerModel({
    this.id,
    this.profilePicture,
    this.dateOfBirth,
    this.dateOfJoining,
    this.gender,
    this.maritalStatus,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.employeeId,
    this.departmentId,
    this.designation,
    this.employeeType,
    this.employeeStatus,
    this.salary,
    this.bankName,
    this.bankAccountName,
    this.bankAccountNumber,
    this.bankIfscCode,
    this.bankBranch,
    this.bankCity,
    this.rating,
    this.leaveBalance,
    this.emergencyNumber,
    this.benifits,
    this.probabationPeriod,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.department,
    this.employee,
  });

  factory ManpowerModel.fromJson(Map<String, dynamic> json) => ManpowerModel(
        id: json["id"],
        profilePicture: json["profile_picture"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        dateOfJoining: json["date_of_joining"] ?? "N/A",
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        employeeId: json["employee_id"],
        departmentId: json["department_id"],
        designation: json["designation"],
        employeeType: json["employee_type"],
        employeeStatus: json["employee_status"],
        salary: json["salary"],
        bankName: json["bank_name"],
        bankAccountName: json["bank_account_name"],
        bankAccountNumber: json["bank_account_number"],
        bankIfscCode: json["bank_ifsc_code"],
        bankBranch: json["bank_branch"],
        bankCity: json["bank_city"],
        rating: json["rating"],
        leaveBalance: json["leave_balance"],
        emergencyNumber: json["emergency_number"],
        benifits: json["benifits"],
        probabationPeriod: json["probabation_period"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        department: json["department"] == null
            ? null
            : Department.fromJson(json["department"]),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_picture": profilePicture,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "date_of_joining": dateOfJoining,
        "gender": gender,
        "marital_status": maritalStatus,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "employee_id": employeeId,
        "department_id": departmentId,
        "designation": designation,
        "employee_type": employeeType,
        "employee_status": employeeStatus,
        "salary": salary,
        "bank_name": bankName,
        "bank_account_name": bankAccountName,
        "bank_account_number": bankAccountNumber,
        "bank_ifsc_code": bankIfscCode,
        "bank_branch": bankBranch,
        "bank_city": bankCity,
        "rating": rating,
        "leave_balance": leaveBalance,
        "emergency_number": emergencyNumber,
        "benifits": benifits,
        "probabation_period": probabationPeriod,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "department": department?.toJson(),
        "employee": employee?.toJson(),
      };
}

class Department {
  final int? id;
  final String? name;
  final String? description;
  final int? status;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Department({
    this.id,
    this.name,
    this.description,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"]??"N/A",
        description: json["description"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Employee {
  final int? id;
  final String? name;
  final String? slug;
  final dynamic designation;
  final String? phone;
  final dynamic avatar;
  final int? active;
  final String? email;
  final String? role;
  final String? locale;
  final String? accountType;
  final dynamic rememberMeToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? invalidLoginAttempts;

  Employee({
    this.id,
    this.name,
    this.slug,
    this.designation,
    this.phone,
    this.avatar,
    this.active,
    this.email,
    this.role,
    this.locale,
    this.accountType,
    this.rememberMeToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.invalidLoginAttempts,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"] ?? "N/A",
        slug: json["slug"],
        designation: json["designation"],
        phone: json["phone"],
        avatar: json["avatar"],
        active: json["active"],
        email: json["email"],
        role: json["role"],
        locale: json["locale"],
        accountType: json["account_type"],
        rememberMeToken: json["remember_me_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        invalidLoginAttempts: json["invalid_login_attempts"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "designation": designation,
        "phone": phone,
        "avatar": avatar,
        "active": active,
        "email": email,
        "role": role,
        "locale": locale,
        "account_type": accountType,
        "remember_me_token": rememberMeToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "invalid_login_attempts": invalidLoginAttempts,
      };
}
