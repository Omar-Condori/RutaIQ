// lib/repositories/empresa_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/empresa_model.dart';
import '../core/errors/exceptions.dart';

class EmpresaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener empresa por ID
  Future<EmpresaModel> getEmpresaById(String empresaId) async {
    try {
      final doc = await _firestore.collection('empresas').doc(empresaId).get();
      if (!doc.exists) {
        throw FirestoreException('Empresa no encontrada');
      }
      return EmpresaModel.fromFirestore(doc);
    } catch (e) {
      throw FirestoreException('Error obteniendo empresa: ${e.toString()}');
    }
  }

  // Obtener empresa por admin ID
  Future<EmpresaModel?> getEmpresaByAdminId(String adminId) async {
    try {
      final query = await _firestore
          .collection('empresas')
          .where('adminId', isEqualTo: adminId)
          .limit(1)
          .get();
      
      if (query.docs.isEmpty) return null;
      return EmpresaModel.fromFirestore(query.docs.first);
    } catch (e) {
      throw FirestoreException('Error obteniendo empresa por admin: ${e.toString()}');
    }
  }

  // Obtener todas las empresas (solo para super admin)
  Future<List<EmpresaModel>> getAllEmpresas() async {
    try {
      final query = await _firestore.collection('empresas').get();
      return query.docs.map((doc) => EmpresaModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw FirestoreException('Error obteniendo empresas: ${e.toString()}');
    }
  }

  // Crear nueva empresa
  Future<EmpresaModel> createEmpresa(EmpresaModel empresa) async {
    try {
      final docRef = await _firestore.collection('empresas').add(empresa.toJson());
      return empresa.copyWith(id: docRef.id);
    } catch (e) {
      throw FirestoreException('Error creando empresa: ${e.toString()}');
    }
  }

  // Actualizar empresa
  Future<void> updateEmpresa(EmpresaModel empresa) async {
    try {
      await _firestore
          .collection('empresas')
          .doc(empresa.id)
          .update(empresa.toJson());
    } catch (e) {
      throw FirestoreException('Error actualizando empresa: ${e.toString()}');
    }
  }

  // Eliminar empresa
  Future<void> deleteEmpresa(String empresaId) async {
    try {
      await _firestore.collection('empresas').doc(empresaId).delete();
    } catch (e) {
      throw FirestoreException('Error eliminando empresa: ${e.toString()}');
    }
  }

  // Verificar si un usuario es admin de una empresa específica
  Future<bool> isUserAdminOfEmpresa(String userId, String empresaId) async {
    try {
      final empresa = await getEmpresaById(empresaId);
      return empresa.adminId == userId;
    } catch (e) {
      return false;
    }
  }
}
