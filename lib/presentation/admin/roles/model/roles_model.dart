// To parse this JSON data, do
//
//     final rolesModel = rolesModelFromJson(jsonString);

import 'dart:convert';

List<RolesModel> rolesModelFromJson(String str) => List<RolesModel>.from(json.decode(str).map((x) => RolesModel.fromJson(x)));

String rolesModelToJson(List<RolesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RolesModel {
    final int? id;
    final String? name;
    final String? slug;
    final int? secondary;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Permission>? permissions;

    RolesModel({
        this.id,
        this.name,
        this.slug,
        this.secondary,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.permissions,
    });

    factory RolesModel.fromJson(Map<String, dynamic> json) => RolesModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        secondary: json["secondary"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        permissions: json["permissions"] == null ? [] : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "secondary": secondary,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
    };
}

class Permission {
    final int? id;
    final String? name;
    final String? slug;

    Permission({
        this.id,
        this.name,
        this.slug,
    });

    factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}
