// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<UserModel?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final userRoleProvider = FutureProvider.family<String, String>((ref, uid) {
  return ref.watch(authServiceProvider).getUserRole(uid);
});

final currentUserEmpresaProvider = FutureProvider.family<String?, String>((ref, uid) async {
  final user = await ref.watch(authServiceProvider).getUserById(uid);
  return user?.empresaId;
});

final authProvider = StreamProvider<UserModel?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.loading());

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // No cambiamos el estado aquí, el authStateChanges se encargará
    } catch (e, stack) {
      // Solo manejamos errores, no cambiamos el estado principal
      rethrow;
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> register(String email, String password, {String? name}) async {
    try {
      await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      // No cambiamos el estado aquí, el authStateChanges se encargará
    } catch (e, stack) {
      // Solo manejamos errores, no cambiamos el estado principal
      rethrow;
    }
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});

// Provider separado para el estado del proceso de registro
class RegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  RegisterNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> register(String email, String password, {String? name}) async {
    state = const AsyncValue.loading();
    try {
      await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      // Esperar un poco para que Firebase Auth se actualice
      await Future.delayed(const Duration(milliseconds: 500));
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final registerNotifierProvider = StateNotifierProvider<RegisterNotifier, AsyncValue<void>>((ref) {
  return RegisterNotifier(ref.watch(authServiceProvider));
});

// Provider separado para el estado del proceso de login
class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  LoginNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>((ref) {
  return LoginNotifier(ref.watch(authServiceProvider));
});