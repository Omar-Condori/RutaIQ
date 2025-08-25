// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../core/errors/exceptions.dart';
import '../core/constants/app_constants.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream del usuario actual
  Stream<UserModel?> get authStateChanges => _firebaseAuth.authStateChanges().asyncMap((user) async {
    if (user == null) return null;
    
    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return UserModel.fromFirestore(userDoc);
      } else {
        // Crear usuario en Firestore si no existe
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          role: AppConstants.ROLE_PASSENGER,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
        return newUser;
      }
    } catch (e) {
      throw FirestoreException('Error obteniendo usuario: ${e.toString()}');
    }
  });

  // Usuario actual
  User? get currentUser => _firebaseAuth.currentUser;

  // Iniciar sesión con email y contraseña
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final userDoc = await _firestore.collection('users').doc(result.user!.uid).get();
      if (userDoc.exists) {
        return UserModel.fromFirestore(userDoc);
      } else {
        throw AuthException('Usuario no encontrado en la base de datos');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Error inesperado: ${e.toString()}');
    }
  }

  // Registrar usuario
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final newUser = UserModel(
        id: result.user!.uid,
        email: email,
        name: name ?? '',
        role: AppConstants.ROLE_PASSENGER,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _firestore.collection('users').doc(result.user!.uid).set(newUser.toJson());
      return newUser;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Error inesperado: ${e.toString()}');
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Error al cerrar sesión: ${e.toString()}');
    }
  }

  // Recuperar contraseña
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Error inesperado: ${e.toString()}');
    }
  }

  // Obtener usuario por ID
  Future<UserModel?> getUserById(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromFirestore(userDoc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Obtener rol del usuario
  Future<String> getUserRole(String uid) async {
    try {
      // Primero intentar leer el rol desde el documento del usuario
      final userDoc = await _firestore.collection('users').doc(uid).get();
      
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final role = userData['role'] as String?;
        if (role != null && role.isNotEmpty) {
          return role;
        }
      }

      // Si no se encuentra en users, verificar otras colecciones
      try {
        // Verificar si es admin
        final adminDoc = await _firestore
            .collection('admins')
            .where('uid', isEqualTo: uid)
            .limit(1)
            .get();

        if (adminDoc.docs.isNotEmpty) return AppConstants.ROLE_ADMIN;
      } catch (e) {
        // Si no tiene permisos para admins, continuar
      }

      try {
        // Verificar si es conductor
        final driverDoc = await _firestore
            .collection('drivers')
            .where('uid', isEqualTo: uid)
            .limit(1)
            .get();

        if (driverDoc.docs.isNotEmpty) return AppConstants.ROLE_DRIVER;
      } catch (e) {
        // Si no tiene permisos para drivers, continuar
      }

      // Por defecto es pasajero
      return AppConstants.ROLE_PASSENGER;
    } catch (e) {
      // Si hay error, retornar pasajero por defecto en lugar de lanzar excepción
      return AppConstants.ROLE_PASSENGER;
    }
  }

  // Asociar empresa al usuario
  Future<void> associateUserWithEmpresa(String userId, String empresaId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'empresaId': empresaId,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw FirestoreException('Error asociando usuario con empresa: ${e.toString()}');
    }
  }

  // Mensajes de error personalizados
  String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'email-already-in-use':
        return 'El email ya está en uso';
      case 'weak-password':
        return 'La contraseña debe tener al menos 6 caracteres';
      case 'invalid-email':
        return 'Email inválido';
      case 'user-disabled':
        return 'Usuario deshabilitado';
      case 'too-many-requests':
        return 'Demasiados intentos, intenta más tarde';
      case 'network-request-failed':
        return 'Error de conexión. Verifica tu internet';
      case 'operation-not-allowed':
        return 'Registro con email no está habilitado';
      default:
        return 'Error de autenticación: $errorCode';
    }
  }
}