class EmployeeModel{
final String? id;
final String? name;
final String? gender;
final String? email;
final String? phone;
final String? role;
final String? department;
final String? material;
final String? avatar;

EmployeeModel({
  this.id,
  this.name,
  this.gender,
  this.email,
  this.phone,
  this.role,
  this.department,
  this.material,
  this.avatar

});
factory EmployeeModel.fromJson(Map<String, dynamic> json) {
  return EmployeeModel(
    id: json['id'],
    name: json['name'],
    gender: json['gender'],
    email: json['email'],
    phone: json['phone'],
    role: json['role'],
    department: json['department'],
    material: json['material'],
    avatar: json['avtar']
  );
  }
  

}