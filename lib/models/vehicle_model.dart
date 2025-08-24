// lib/models/vehicle_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

enum VehicleStatus { activo, inactivo, mantenimiento }

class VehicleModel {
  final String id;
  final String placa;
  final String numeroInterno;
  final String empresaId;
  final String? lineaActualId;
  final String? conductorId;
  final VehicleStatus estado;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VehicleModel({
    required this.id,
    required this.placa,
    required this.numeroInterno,
    required this.empresaId,
    this.lineaActualId,
    this.conductorId,
    this.estado = VehicleStatus.activo,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json, String id) {
    return VehicleModel(
      id: id,
      placa: json['placa'] ?? '',
      numeroInterno: json['numero_interno'] ?? '',
      empresaId: json['empresaId'] ?? '',
      lineaActualId: json['lineaActualId'],
      conductorId: json['conductorId'],
      estado: _parseEstado(json['estado']),
      createdAt: json['createdAt']?.toDate(),
      updatedAt: json['updatedAt']?.toDate(),
    );
  }

  static VehicleStatus _parseEstado(String? estado) {
    switch (estado) {
      case 'activo':
        return VehicleStatus.activo;
      case 'inactivo':
        return VehicleStatus.inactivo;
      case 'mantenimiento':
        return VehicleStatus.mantenimiento;
      default:
        return VehicleStatus.activo;
    }
  }

  factory VehicleModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return VehicleModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'placa': placa,
      'numero_interno': numeroInterno,
      'empresaId': empresaId,
      'lineaActualId': lineaActualId,
      'conductorId': conductorId,
      'estado': estado.name,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}