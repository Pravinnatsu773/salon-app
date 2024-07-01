import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:salonapp/screens/home/cubit/home_service_cubit.dart';
import 'package:salonapp/services/error_service.dart';

abstract class HomeServiceRepository {
  Future<Either<ErrorService, Response?>> getSericeByType();
}
