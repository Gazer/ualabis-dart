import 'dart:ffi';

import 'error_type.dart';

class UalaError implements Exception {
  final String message;
  final ErrorType type;
  final int statusCode;

  UalaError({
    required this.message,
    required String? errorCode,
    required this.statusCode,
  }) : type = ErrorType.values.firstWhere((element) => element.code.toString() == errorCode);
}