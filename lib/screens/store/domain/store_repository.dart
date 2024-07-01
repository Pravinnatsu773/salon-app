import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:salonapp/services/error_service.dart';

abstract class StoreRepository {
  Future<Either<ErrorService, Response?>> getServiceOrProduct();
}
