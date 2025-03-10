// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  int id;
  String desinationName;

  LocationModel({
    required this.id,
    required this.desinationName,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["Id"],
        desinationName: json["DesinationName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DesinationName": desinationName,
      };
}
