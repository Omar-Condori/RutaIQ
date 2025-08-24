// lib/core/errors/exceptions.dart
class AppException implements Exception {
  final String message;
  final String code;

  AppException(this.message, {this.code = 'unknown'});

  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(String message) : super(message, code: 'auth');
}

class FirestoreException extends AppException {
  FirestoreException(String message) : super(message, code: 'firestore');
}

class StorageException extends AppException {
  StorageException(String message) : super(message, code: 'storage');
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message, code: 'network');
}