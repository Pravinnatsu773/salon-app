import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:salonapp/services/error_service.dart';

abstract class ProfileRepository {
  const ProfileRepository();

  Future<Either<ErrorService, Response?>> getProfile();

  Future<Either<ErrorService, Response?>> updateProfile(
      Map<String, dynamic> data);
}
