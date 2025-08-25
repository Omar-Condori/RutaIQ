// lib/providers/complaint_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/complaint_model.dart';
import '../services/firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final complaintsByEmpresaProvider = FutureProvider.family<List<ComplaintModel>, String>((ref, empresaId) {
  return ref.watch(firestoreServiceProvider).getComplaintsByEmpresa(empresaId);
});

class ComplaintNotifier extends StateNotifier<AsyncValue<List<ComplaintModel>>> {
  final FirestoreService _firestoreService;
  final String _empresaId;

  ComplaintNotifier(this._firestoreService, this._empresaId)
      : super(const AsyncValue.loading()) {
    loadComplaints();
  }

  Future<void> loadComplaints() async {
    try {
      state = const AsyncValue.loading();
      final complaints = await _firestoreService.getComplaintsByEmpresa(_empresaId);
      state = AsyncValue.data(complaints);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createComplaint(ComplaintModel complaint) async {
    try {
      await _firestoreService.createComplaint(complaint);
      await loadComplaints();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateComplaint(String complaintId, Map<String, dynamic> data) async {
    try {
      await _firestoreService.updateComplaint(complaintId, data);
      await loadComplaints();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final complaintNotifierProvider = StateNotifierProvider.family<ComplaintNotifier, AsyncValue<List<ComplaintModel>>, String>((ref, empresaId) {
  return ComplaintNotifier(ref.watch(firestoreServiceProvider), empresaId);
});
