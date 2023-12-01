// To parse this JSON data, do
//
//     final permmissionModel = permmissionModelFromJson(jsonString);

import 'dart:convert';

List<PermmissionModel> permmissionModelFromJson(String str) => List<PermmissionModel>.from(json.decode(str).map((x) => PermmissionModel.fromJson(x)));

String permmissionModelToJson(List<PermmissionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PermmissionModel {
    final String? group;
    final List<Datum>? data;

    PermmissionModel({
        this.group,
        this.data,
    });

    factory PermmissionModel.fromJson(Map<String, dynamic> json) => PermmissionModel(
        group: json["group"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "group": group,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final int? id;
    final String? name;
    final String? slug;
    final String? description;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? group;

    Datum({
        this.id,
        this.name,
        this.slug,
        this.description,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.group,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        group: json["group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "group": group,
    };
}
