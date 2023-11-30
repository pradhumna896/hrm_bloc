// To parse this JSON data, do
//
//     final projectmodel = projectmodelFromJson(jsonString);

import 'dart:convert';

List<Projectmodel> projectmodelFromJson(String str) => List<Projectmodel>.from(json.decode(str).map((x) => Projectmodel.fromJson(x)));

String projectmodelToJson(List<Projectmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Projectmodel {
    final int? id;
    final int? projectManagerId;
    final String? projectName;
    final String? projectDescription;
    final String? projectType;
    final String? projectStatus;
    final DateTime? startDate;
    final DateTime? endDate;
    final dynamic deletedAt;
    final dynamic createdAt;
    final DateTime? updatedAt;

    Projectmodel({
        this.id,
        this.projectManagerId,
        this.projectName,
        this.projectDescription,
        this.projectType,
        this.projectStatus,
        this.startDate,
        this.endDate,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Projectmodel.fromJson(Map<String, dynamic> json) => Projectmodel(
        id: json["id"],
        projectManagerId: json["project_manager_id"],
        projectName: json["project_name"],
        projectDescription: json["project_description"],
        projectType: json["project_type"],
        projectStatus: json["project_status"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "project_manager_id": projectManagerId,
        "project_name": projectName,
        "project_description": projectDescription,
        "project_type": projectType,
        "project_status": projectStatus,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
    };
}
