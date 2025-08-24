// lib/models/route_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderedStop {
  final String stopId;
  final double lat;
  final double lng;
  final int seq;

  OrderedStop({
    required this.stopId,
    required this.lat,
    required this.lng,
    required this.seq,
  });

  factory OrderedStop.fromJson(Map<String, dynamic> json) {
    return OrderedStop(
      stopId: json['stopId'] ?? '',
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
      seq: json['seq'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stopId': stopId,
      'lat': lat,
      'lng': lng,
      'seq': seq,
    };
  }
}

class RouteModel {
  final String id;
  final String polylineEncoded;
  final List<OrderedStop> orderedStops;
  final bool bidireccional;

  RouteModel({
    required this.id,
    required this.polylineEncoded,
    required this.orderedStops,
    this.bidireccional = false,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json, String id) {
    return RouteModel(
      id: id,
      polylineEncoded: json['polylineEncoded'] ?? '',
      orderedStops: (json['orderedStops'] as List?)
          ?.map((stop) => OrderedStop.fromJson(stop))
          .toList() ??
          [],
      bidireccional: json['bidireccional'] ?? false,
    );
  }

  factory RouteModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return RouteModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'polylineEncoded': polylineEncoded,
      'orderedStops': orderedStops.map((stop) => stop.toJson()).toList(),
      'bidireccional': bidireccional,
    };
  }
}