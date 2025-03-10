// To parse this JSON data, do
//
//     final getAllTanureModel = getAllTanureModelFromJson(jsonString);

import 'dart:convert';

GetAllTanureModel getAllTanureModelFromJson(String str) => GetAllTanureModel.fromJson(json.decode(str));

String getAllTanureModelToJson(GetAllTanureModel data) => json.encode(data.toJson());

class GetAllTanureModel {
  DateTime? dOjoining;
  String? tenure;
  int? nights;
  int? days;
  bool? isactive;
  String? message;
  int? status;

  GetAllTanureModel({
    this.dOjoining,
    this.tenure,
    this.nights,
    this.days,
    this.isactive,
    this.message,
    this.status,
  });

  factory GetAllTanureModel.fromJson(Map<String, dynamic> json) => GetAllTanureModel(
    dOjoining: json["DOjoining"] == null ? null : DateTime.parse(json["DOjoining"]),
    tenure: json["Tenure"],
    nights: json["Nights"],
    days: json["Days"],
    isactive: json["Isactive"],
    message: json["Message"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "DOjoining": "${dOjoining!.year.toString().padLeft(4, '0')}-${dOjoining!.month.toString().padLeft(2, '0')}-${dOjoining!.day.toString().padLeft(2, '0')}",
    "Tenure": tenure,
    "Nights": nights,
    "Days": days,
    "Isactive": isactive,
    "Message": message,
    "Status": status,
  };
}
