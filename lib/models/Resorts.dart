// To parse this JSON data, do
//
//     final resorts = resortsFromJson(jsonString);

import 'dart:convert';

List<Resorts> resortsFromJson(String str) => List<Resorts>.from(json.decode(str).map((x) => Resorts.fromJson(x)));

String resortsToJson(List<Resorts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Resorts {
  int? id;
  String? desinationName;
  String? placeName;
  String? description;
  String? imageName;

  Resorts({
    this.id,
    this.desinationName,
    this.placeName,
    this.description,
    this.imageName,
  });

  factory Resorts.fromJson(Map<String, dynamic> json) => Resorts(
    id: json["Id"],
    desinationName: json["DesinationName"],
    placeName: json["PlaceName"],
    description: json["Description"],
    imageName: json["ImageName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "DesinationName": desinationName,
    "PlaceName": placeName,
    "Description": description,
    "ImageName": imageName,
  };
}
