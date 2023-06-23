// To parse this JSON data, do
//
//     final geoCoding = geoCodingFromMap(jsonString);

import 'dart:convert';

class GeoCoding {
  GeoCoding({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  String type;
  List<double> query;
  List<Feature> features;
  String attribution;

  factory GeoCoding.fromJson(String str) => GeoCoding.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeoCoding.fromMap(Map<String, dynamic> json) => GeoCoding(
        type: json["type"],
        query: List<double>.from(json["query"].map((x) => x?.toDouble())),
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    this.address,
    this.context,
    this.bbox,
  });

  String id;
  String type;
  List<String> placeType;
  int relevance;
  Properties properties;
  String text;
  String placeName;
  List<double> center;
  Geometry geometry;
  String? address;
  List<Context>? context;
  List<double>? bbox;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromMap(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        address: json["address"],
        context: json["context"] == null
            ? []
            : List<Context>.from(
                json["context"]!.map((x) => Context.fromMap(x))),
        bbox: json["bbox"] == null
            ? []
            : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toMap(),
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "address": address,
        "context": context == null
            ? []
            : List<dynamic>.from(context!.map((x) => x.toMap())),
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
      };
}

class Context {
  Context({
    required this.id,
    required this.wikidata,
    required this.text,
    this.shortCode,
  });

  String id;
  String wikidata;
  String text;
  String? shortCode;

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        wikidata: json["wikidata"],
        text: json["text"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "wikidata": wikidata,
        "text": text,
        "short_code": shortCode,
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.accuracy,
    this.wikidata,
    this.shortCode,
  });

  String? accuracy;
  String? wikidata;
  String? shortCode;

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        accuracy: json["accuracy"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toMap() => {
        "accuracy": accuracy,
        "wikidata": wikidata,
        "short_code": shortCode,
      };
}
