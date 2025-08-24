// lib/models/stop_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class StopModel {
  final String id;
  final String nombre;
  final double lat;
  final double lng;
  final List<String> tags;

  StopModel({
    required this.id,
    required this.nombre,
    required this.lat,
    required this.lng,
    required this.tags,
  });

  factory StopModel.fromJson(Map<String, dynamic> json, String id) {
    return StopModel(
      id: id,
      nombre: json['nombre'] ?? '',
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  factory StopModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return StopModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'lat': lat,
      'lng': lng,
      'tags': tags,
    };
  }
}