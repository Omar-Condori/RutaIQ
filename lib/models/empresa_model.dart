// lib/models/empresa_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class EmpresaModel {
  final String id;
  final String nombre;
  final String ruc;
  final String contacto;
  final String? adminId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? configuracion;

  EmpresaModel({
    required this.id,
    required this.nombre,
    required this.ruc,
    required this.contacto,
    this.adminId,
    required this.createdAt,
    required this.updatedAt,
    this.configuracion,
  });

  factory EmpresaModel.fromJson(Map<String, dynamic> json, String id) {
    return EmpresaModel(
      id: id,
      nombre: json['nombre'] ?? '',
      ruc: json['ruc'] ?? '',
      contacto: json['contacto'] ?? '',
      adminId: json['adminId'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      configuracion: json['configuracion'],
    );
  }

  factory EmpresaModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return EmpresaModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'ruc': ruc,
      'contacto': contacto,
      'adminId': adminId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'configuracion': configuracion ?? {},
    };
  }

  EmpresaModel copyWith({
    String? id,
    String? nombre,
    String? ruc,
    String? contacto,
    String? adminId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? configuracion,
  }) {
    return EmpresaModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      ruc: ruc ?? this.ruc,
      contacto: contacto ?? this.contacto,
      adminId: adminId ?? this.adminId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      configuracion: configuracion ?? this.configuracion,
    );
  }
}