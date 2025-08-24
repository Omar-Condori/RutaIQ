// lib/services/storage_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../core/errors/exceptions.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadComplaintEvidence({
    required File file,
    required String complaintId,
    required String fileName,
  }) async {
    try {
      final ref = _storage.ref().child('complaints/$complaintId/$fileName');
      final uploadTask = await ref.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw StorageException('Error subiendo evidencia: ${e.toString()}');
    }
  }

  Future<String> uploadProfileImage({
    required File file,
    required String userId,
  }) async {
    try {
      final ref = _storage.ref().child('profiles/$userId.jpg');
      final uploadTask = await ref.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw StorageException('Error subiendo imagen: ${e.toString()}');
    }
  }

  Future<void> deleteFile(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (e) {
      throw StorageException('Error eliminando archivo: ${e.toString()}');
    }
  }
}