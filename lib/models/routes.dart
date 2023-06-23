// To parse this JSON data, do
//
//     final routes = routesFromMap(jsonString);

import 'dart:convert';

class Routes {
    Routes({
        required this.routes,
        required this.waypoints,
        required this.code,
        required this.uuid,
    });

    List<Route> routes;
    List<Waypoint> waypoints;
    String code;
    String uuid;

    factory Routes.fromJson(String str) => Routes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Routes.fromMap(Map<String, dynamic> json) => Routes(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
        waypoints: List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromMap(x))),
        code: json["code"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toMap() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toMap())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toMap())),
        "code": code,
        "uuid": uuid,
    };
}

class Route {
    Route({
        required this.countryCrossed,
        required this.weightName,
        required this.weight,
        required this.duration,
        required this.distance,
        required this.legs,
        required this.geometry,
    });

    bool countryCrossed;
    String weightName;
    double weight;
    double duration;
    double distance;
    List<Leg> legs;
    Geometry geometry;

    factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Route.fromMap(Map<String, dynamic> json) => Route(
        countryCrossed: json["country_crossed"],
        weightName: json["weight_name"],
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
        geometry: Geometry.fromMap(json["geometry"]),
    );

    Map<String, dynamic> toMap() => {
        "country_crossed": countryCrossed,
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toMap())),
        "geometry": geometry.toMap(),
    };
}

class Geometry {
    Geometry({
        required this.coordinates,
        required this.type,
    });

    List<List<double>> coordinates;
    Type type;

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": typeValues.reverse[type],
    };
}

enum Type { LINE_STRING }

final typeValues = EnumValues({
    "LineString": Type.LINE_STRING
});

class Leg {
    Leg({
        required this.viaWaypoints,
        required this.admins,
        required this.weight,
        required this.duration,
        required this.steps,
        required this.distance,
        required this.summary,
    });

    List<dynamic> viaWaypoints;
    List<Admin> admins;
    double weight;
    double duration;
    List<Step> steps;
    double distance;
    String summary;

    factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromMap(x))),
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromMap(x))),
        distance: json["distance"]?.toDouble(),
        summary: json["summary"],
    );

    Map<String, dynamic> toMap() => {
        "via_waypoints": List<dynamic>.from(viaWaypoints.map((x) => x)),
        "admins": List<dynamic>.from(admins.map((x) => x.toMap())),
        "weight": weight,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x.toMap())),
        "distance": distance,
        "summary": summary,
    };
}

class Admin {
    Admin({
        required this.iso31661Alpha3,
        required this.iso31661,
    });

    String iso31661Alpha3;
    String iso31661;

    factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
    );

    Map<String, dynamic> toMap() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
    };
}

class Step {
    Step({
        required this.intersections,
        required this.maneuver,
        required this.name,
        required this.duration,
        required this.distance,
        required this.drivingSide,
        required this.weight,
        required this.mode,
        required this.geometry,
    });

    List<Intersection> intersections;
    Maneuver maneuver;
    String name;
    double duration;
    double distance;
    DrivingSide drivingSide;
    double weight;
    Mode mode;
    Geometry geometry;

    factory Step.fromJson(String str) => Step.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Step.fromMap(Map<String, dynamic> json) => Step(
        intersections: List<Intersection>.from(json["intersections"].map((x) => Intersection.fromMap(x))),
        maneuver: Maneuver.fromMap(json["maneuver"]),
        name: json["name"],
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        drivingSide: drivingSideValues.map[json["driving_side"]]!,
        weight: json["weight"]?.toDouble(),
        mode: modeValues.map[json["mode"]]!,
        geometry: Geometry.fromMap(json["geometry"]),
    );

    Map<String, dynamic> toMap() => {
        "intersections": List<dynamic>.from(intersections.map((x) => x.toMap())),
        "maneuver": maneuver.toMap(),
        "name": name,
        "duration": duration,
        "distance": distance,
        "driving_side": drivingSideValues.reverse[drivingSide],
        "weight": weight,
        "mode": modeValues.reverse[mode],
        "geometry": geometry.toMap(),
    };
}

enum DrivingSide { RIGHT, STRAIGHT, LEFT }

final drivingSideValues = EnumValues({
    "left": DrivingSide.LEFT,
    "right": DrivingSide.RIGHT,
    "straight": DrivingSide.STRAIGHT
});

class Intersection {
    Intersection({
        required this.entry,
        required this.bearings,
        this.duration,
        this.mapboxStreetsV8,
        this.isUrban,
        required this.adminIndex,
        this.out,
        this.weight,
        required this.geometryIndex,
        required this.location,
        this.intersectionIn,
        this.turnDuration,
        this.turnWeight,
        this.lanes,
        this.trafficSignal,
    });

    List<bool> entry;
    List<int> bearings;
    double? duration;
    MapboxStreetsV8? mapboxStreetsV8;
    bool? isUrban;
    int adminIndex;
    int? out;
    double? weight;
    int geometryIndex;
    List<double> location;
    int? intersectionIn;
    double? turnDuration;
    double? turnWeight;
    List<Lane>? lanes;
    bool? trafficSignal;

    factory Intersection.fromJson(String str) => Intersection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Intersection.fromMap(Map<String, dynamic> json) => Intersection(
        entry: List<bool>.from(json["entry"].map((x) => x)),
        bearings: List<int>.from(json["bearings"].map((x) => x)),
        duration: json["duration"]?.toDouble(),
        mapboxStreetsV8: json["mapbox_streets_v8"] == null ? null : MapboxStreetsV8.fromMap(json["mapbox_streets_v8"]),
        isUrban: json["is_urban"],
        adminIndex: json["admin_index"],
        out: json["out"],
        weight: json["weight"]?.toDouble(),
        geometryIndex: json["geometry_index"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        intersectionIn: json["in"],
        turnDuration: json["turn_duration"]?.toDouble(),
        turnWeight: json["turn_weight"]?.toDouble(),
        lanes: json["lanes"] == null ? [] : List<Lane>.from(json["lanes"]!.map((x) => Lane.fromMap(x))),
        trafficSignal: json["traffic_signal"],
    );

    Map<String, dynamic> toMap() => {
        "entry": List<dynamic>.from(entry.map((x) => x)),
        "bearings": List<dynamic>.from(bearings.map((x) => x)),
        "duration": duration,
        "mapbox_streets_v8": mapboxStreetsV8?.toMap(),
        "is_urban": isUrban,
        "admin_index": adminIndex,
        "out": out,
        "weight": weight,
        "geometry_index": geometryIndex,
        "location": List<dynamic>.from(location.map((x) => x)),
        "in": intersectionIn,
        "turn_duration": turnDuration,
        "turn_weight": turnWeight,
        "lanes": lanes == null ? [] : List<dynamic>.from(lanes!.map((x) => x.toMap())),
        "traffic_signal": trafficSignal,
    };
}

class Lane {
    Lane({
        required this.indications,
        this.validIndication,
        required this.valid,
        required this.active,
    });

    List<DrivingSide> indications;
    DrivingSide? validIndication;
    bool valid;
    bool active;

    factory Lane.fromJson(String str) => Lane.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Lane.fromMap(Map<String, dynamic> json) => Lane(
        indications: List<DrivingSide>.from(json["indications"].map((x) => drivingSideValues.map[x]!)),
        validIndication: drivingSideValues.map[json["valid_indication"]]!,
        valid: json["valid"],
        active: json["active"],
    );

    Map<String, dynamic> toMap() => {
        "indications": List<dynamic>.from(indications.map((x) => drivingSideValues.reverse[x])),
        "valid_indication": drivingSideValues.reverse[validIndication],
        "valid": valid,
        "active": active,
    };
}

class MapboxStreetsV8 {
    MapboxStreetsV8({
        required this.mapboxStreetsV8Class,
    });

    Class mapboxStreetsV8Class;

    factory MapboxStreetsV8.fromJson(String str) => MapboxStreetsV8.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MapboxStreetsV8.fromMap(Map<String, dynamic> json) => MapboxStreetsV8(
        mapboxStreetsV8Class: classValues.map[json["class"]]!,
    );

    Map<String, dynamic> toMap() => {
        "class": classValues.reverse[mapboxStreetsV8Class],
    };
}

enum Class { PRIMARY, STREET, ROUNDABOUT, TERTIARY, TRUNK }

final classValues = EnumValues({
    "primary": Class.PRIMARY,
    "roundabout": Class.ROUNDABOUT,
    "street": Class.STREET,
    "tertiary": Class.TERTIARY,
    "trunk": Class.TRUNK
});

class Maneuver {
    Maneuver({
        required this.type,
        required this.instruction,
        required this.bearingAfter,
        required this.bearingBefore,
        required this.location,
        this.modifier,
        this.exit,
    });

    String type;
    String instruction;
    int bearingAfter;
    int bearingBefore;
    List<double> location;
    String? modifier;
    int? exit;

    factory Maneuver.fromJson(String str) => Maneuver.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Maneuver.fromMap(Map<String, dynamic> json) => Maneuver(
        type: json["type"],
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        modifier: json["modifier"],
        exit: json["exit"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location": List<dynamic>.from(location.map((x) => x)),
        "modifier": modifier,
        "exit": exit,
    };
}

enum Mode { DRIVING }

final modeValues = EnumValues({
    "driving": Mode.DRIVING
});

class Waypoint {
    Waypoint({
        required this.distance,
        required this.name,
        required this.location,
    });

    double distance;
    String name;
    List<double> location;

    factory Waypoint.fromJson(String str) => Waypoint.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Waypoint.fromMap(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
