// lib/core/utils/validators.dart
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }
    if (!RegExp(r'^\+?[1-9]\d{8,14}$').hasMatch(value.replaceAll(' ', ''))) {
      return 'Número de teléfono inválido';
    }
    return null;
  }

  static String? required(String? value, {String field = 'Campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field es requerido';
    }
    return null;
  }

  static String? plateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'La placa es requerida';
    }
    if (!RegExp(r'^[A-Z]{3}-[0-9]{3}$').hasMatch(value.toUpperCase())) {
      return 'Formato de placa inválido (Ej: ABC-123)';
    }
    return null;
  }

  static String? ruc(String? value) {
    if (value == null || value.isEmpty) {
      return 'El RUC es requerido';
    }
    if (value.length != 11 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'RUC debe tener 11 dígitos';
    }
    return null;
  }
}