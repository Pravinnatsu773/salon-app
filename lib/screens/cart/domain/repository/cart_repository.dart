import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:salonapp/services/error_service.dart';

abstract class CartRepository {
  Future<Either<ErrorService, Response?>> createCart(
      List<Map<String, dynamic>> cartData);
}
