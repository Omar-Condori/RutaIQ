// lib/models/position_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class PositionModel {
  final String id;
  final String vehicleId;
  final double lat;
  final double lng;
  final double speed;
  final double heading;
  final DateTime timestamp;
  final String lineId;

  PositionModel({
    required this.id,
    required this.vehicleId,
    required this.lat,
    required this.lng,
    required this.speed,
    required this.heading,
    required this.timestamp,
    required this.lineId,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json, String id) {
    return PositionModel(
      id: id,
      vehicleId: json['vehicleId'] ?? '',
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
      speed: json['speed']?.toDouble() ?? 0.0,
      heading: json['heading']?.toDouble() ?? 0.0,
      timestamp: json['timestamp']?.toDate() ?? DateTime.now(),
      lineId: json['lineId'] ?? '',
    );
  }

  factory PositionModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PositionModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleId': vehicleId,
      'lat': lat,
      'lng': lng,
      'speed': speed,
      'heading': heading,
      'timestamp': Timestamp.fromDate(timestamp),
      'lineId': lineId,
    };
  }
}