// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentModel> departmentModelFromJson(String str) => List<DepartmentModel>.from(json.decode(str).map((x) => DepartmentModel.fromJson(x)));

String departmentModelToJson(List<DepartmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel {
    final int? id;
    final String? name;
    final String? description;
    final int? status;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    DepartmentModel({
        this.id,
        this.name,
        this.description,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
