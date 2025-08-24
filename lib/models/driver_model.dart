// lib/models/driver_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverModel {
  final String id;
  final String uid;
  final String nombre;
  final String telefono;
  final String vehiculoId;
  final String empresaId;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DriverModel({
    required this.id,
    required this.uid,
    required this.nombre,
    required this.telefono,
    required this.vehiculoId,
    required this.empresaId,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json, String id) {
    return DriverModel(
      id: id,
      uid: json['uid'] ?? '',
      nombre: json['nombre'] ?? '',
      telefono: json['telefono'] ?? '',
      vehiculoId: json['vehiculoId'] ?? '',
      empresaId: json['empresaId'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt']?.toDate(),
      updatedAt: json['updatedAt']?.toDate(),
    );
  }

  factory DriverModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DriverModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nombre': nombre,
      'telefono': telefono,
      'vehiculoId': vehiculoId,
      'empresaId': empresaId,
      'isActive': isActive,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}