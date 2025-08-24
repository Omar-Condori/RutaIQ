// lib/models/line_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class LineModel {
  final String id;
  final String empresaId;
  final String nombre;
  final double tarifa;
  final String rutaId;
  final List<String> stops;
  final String color;

  LineModel({
    required this.id,
    required this.empresaId,
    required this.nombre,
    required this.tarifa,
    required this.rutaId,
    required this.stops,
    required this.color,
  });

  factory LineModel.fromJson(Map<String, dynamic> json, String id) {
    return LineModel(
      id: id,
      empresaId: json['empresaId'] ?? '',
      nombre: json['nombre'] ?? '',
      tarifa: json['tarifa']?.toDouble() ?? 0.0,
      rutaId: json['rutaId'] ?? '',
      stops: List<String>.from(json['stops'] ?? []),
      color: json['color'] ?? '#000000',
    );
  }

  factory LineModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return LineModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'empresaId': empresaId,
      'nombre': nombre,
      'tarifa': tarifa,
      'rutaId': rutaId,
      'stops': stops,
      'color': color,
    };
  }
}