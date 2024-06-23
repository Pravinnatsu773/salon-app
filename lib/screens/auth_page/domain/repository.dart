import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:salonapp/services/error_service.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<ErrorService, Response?>> login(String phoneNumber);

  Future<Either<ErrorService, Response?>> verify(
      String phoneNumber, String otp);
}
