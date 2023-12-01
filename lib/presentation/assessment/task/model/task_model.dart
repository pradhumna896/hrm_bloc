// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) => List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
    final int? id;
    final int? projectId;
    final int? createdBy;
    final dynamic priority;
    final String? taskName;
    final String? description;
    final dynamic hours;
    final int? points;
    final DateTime? dueDate;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Assignee>? assignees;
    final Project? project;
    final CurrentAssignee? currentAssignee;

    TaskModel({
        this.id,
        this.projectId,
        this.createdBy,
        this.priority,
        this.taskName,
        this.description,
        this.hours,
        this.points,
        this.dueDate,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.assignees,
        this.project,
        this.currentAssignee,
    });

    factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        projectId: json["project_id"],
        createdBy: json["created_by"],
        priority: json["priority"],
        taskName: json["task_name"],
        description: json["description"],
        hours: json["hours"],
        points: json["points"],
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        assignees: json["assignees"] == null ? [] : List<Assignee>.from(json["assignees"]!.map((x) => Assignee.fromJson(x))),
        project: json["project"] == null ? null : Project.fromJson(json["project"]),
        currentAssignee: json["currentAssignee"] == null ? null : CurrentAssignee.fromJson(json["currentAssignee"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "created_by": createdBy,
        "priority": priority,
        "task_name": taskName,
        "description": description,
        "hours": hours,
        "points": points,
        "due_date": dueDate?.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "assignees": assignees == null ? [] : List<dynamic>.from(assignees!.map((x) => x.toJson())),
        "project": project?.toJson(),
        "currentAssignee": currentAssignee?.toJson(),
    };
}

class Assignee {
    final int? id;
    final String? name;
    final String? slug;
    final dynamic designation;
    final dynamic phone;
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

    Assignee({
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

    factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
        id: json["id"],
        name: json["name"],
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class CurrentAssignee {
    CurrentAssignee();

    factory CurrentAssignee.fromJson(Map<String, dynamic> json) => CurrentAssignee(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Project {
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

    Project({
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

    factory Project.fromJson(Map<String, dynamic> json) => Project(
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
