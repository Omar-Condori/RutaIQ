// lib/providers/position_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/position_model.dart';
import '../services/firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final vehiclePositionsProvider = StreamProvider.family<List<PositionModel>, String>((ref, vehicleId) {
  return ref.watch(firestoreServiceProvider).getVehiclePositionsStream(vehicleId);
});

final lineVehiclesPositionsProvider = StreamProvider.family<List<PositionModel>, String>((ref, lineId) {
  return ref.watch(firestoreServiceProvider).getLineVehiclesPositionsStream(lineId);
});