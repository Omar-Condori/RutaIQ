// lib/models/empresa_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class EmpresaModel {
  final String id;
  final String nombre;
  final String ruc;
  final String contacto;
  final Map<String, dynamic>? configuracion;

  EmpresaModel({
    required this.id,
    required this.nombre,
    required this.ruc,
    required this.contacto,
    this.configuracion,
  });

  factory EmpresaModel.fromJson(Map<String, dynamic> json, String id) {
    return EmpresaModel(
      id: id,
      nombre: json['nombre'] ?? '',
      ruc: json['ruc'] ?? '',
      contacto: json['contacto'] ?? '',
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
      'configuracion': configuracion ?? {},
    };
  }

  EmpresaModel copyWith({
    String? nombre,
    String? ruc,
    String? contacto,
    Map<String, dynamic>? configuracion,
  }) {
    return EmpresaModel(
      id: id,
      nombre: nombre ?? this.nombre,
      ruc: ruc ?? this.ruc,
      contacto: contacto ?? this.contacto,
      configuracion: configuracion ?? this.configuracion,
    );
  }
}