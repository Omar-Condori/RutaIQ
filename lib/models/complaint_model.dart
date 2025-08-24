// lib/models/complaint_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

enum ComplaintType { conducta, servicio, vehiculo, otro }
enum ComplaintStatus { open, inProgress, resolved, closed }

class ComplaintModel {
  final String id;
  final String userId;
  final String userName;
  final String userPhone;
  final String companyId;
  final String? lineId;
  final String? vehicleId;
  final String? driverId;
  final String? tripId;
  final ComplaintType type;
  final int rating;
  final String description;
  final List<String> evidence;
  final ComplaintStatus status;
  final String? adminResponse;
  final String? driverResponse;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool visibleToPublic;

  ComplaintModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.companyId,
    this.lineId,
    this.vehicleId,
    this.driverId,
    this.tripId,
    required this.type,
    required this.rating,
    required this.description,
    required this.evidence,
    required this.status,
    this.adminResponse,
    this.driverResponse,
    required this.createdAt,
    required this.updatedAt,
    this.visibleToPublic = false,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json, String id) {
    return ComplaintModel(
      id: id,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userPhone: json['userPhone'] ?? '',
      companyId: json['companyId'] ?? '',
      lineId: json['lineId'],
      vehicleId: json['vehicleId'],
      driverId: json['driverId'],
      tripId: json['tripId'],
      type: _parseComplaintType(json['type']),
      rating: json['rating'] ?? 0,
      description: json['description'] ?? '',
      evidence: List<String>.from(json['evidence'] ?? []),
      status: _parseComplaintStatus(json['status']),
      adminResponse: json['adminResponse'],
      driverResponse: json['driverResponse'],
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: json['updatedAt']?.toDate() ?? DateTime.now(),
      visibleToPublic: json['visibleToPublic'] ?? false,
    );
  }

  static ComplaintType _parseComplaintType(String? type) {
    switch (type?.toLowerCase()) {
      case 'conducta':
        return ComplaintType.conducta;
      case 'servicio':
        return ComplaintType.servicio;
      case 'vehiculo':
        return ComplaintType.vehiculo;
      default:
        return ComplaintType.otro;
    }
  }

  static ComplaintStatus _parseComplaintStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'open':
        return ComplaintStatus.open;
      case 'inprogress':
        return ComplaintStatus.inProgress;
      case 'resolved':
        return ComplaintStatus.resolved;
      case 'closed':
        return ComplaintStatus.closed;
      default:
        return ComplaintStatus.open;
    }
  }

  factory ComplaintModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ComplaintModel.fromJson(data, doc.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'companyId': companyId,
      'lineId': lineId,
      'vehicleId': vehicleId,
      'driverId': driverId,
      'tripId': tripId,
      'type': type.name,
      'rating': rating,
      'description': description,
      'evidence': evidence,
      'status': status.name,
      'adminResponse': adminResponse,
      'driverResponse': driverResponse,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'visibleToPublic': visibleToPublic,
    };
  }
}