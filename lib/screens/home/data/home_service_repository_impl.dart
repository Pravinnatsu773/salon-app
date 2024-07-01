import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:either_dart/src/either.dart';
import 'package:salonapp/screens/home/cubit/home_service_cubit.dart';
import 'package:salonapp/screens/home/domain/home_service_repository.dart';
import 'package:salonapp/services/api_service.dart';
import 'package:salonapp/services/error_service.dart';
import 'package:salonapp/services/shared_preference_service.dart';

class HomeServiceRepositoryImpl extends HomeServiceRepository {
  final dio = Dio();

  @override
  Future<Either<ErrorService, Response?>> getSericeByType() async {
    try {
      final token = SharedPreferenceService.getString('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response;

      response = await dio.get(ApiService.serviceType);
      print(response.data.toString());
      return Right(response);
    } on DioException catch (e) {
      print(e);
      return Left(ErrorService(msg: e.message ?? '', code: 0));
    } catch (e) {
      print(e);
      return Left(ErrorService(msg: '', code: 0));
    }
  }
}
