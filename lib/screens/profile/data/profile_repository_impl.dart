import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:salonapp/screens/profile/domain/respository/profile_repository.dart';
import 'package:salonapp/services/api_service.dart';
import 'package:salonapp/services/error_service.dart';
import 'package:salonapp/services/shared_preference_service.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final dio = Dio();

  @override
  Future<Either<ErrorService, Response?>> getProfile() async {
    try {
      final token = SharedPreferenceService.getString('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response;

      response = await dio.get(ApiService.profile);
      print(response.data.toString());
      return Right(response);
    } on DioException catch (e) {
      print(e);
      // final er = e as Map<String, dynamic>;
      // Left(ErrorService(msg: er['message'], code: 0));
      print(e);
      return Left(ErrorService(msg: e.message ?? '', code: 0));
    } catch (e) {
      print(e);
      return Left(ErrorService(msg: '', code: 0));
    }
  }

  @override
  Future<Either<ErrorService, Response?>> updateProfile(
      Map<String, dynamic> data) async {
    try {
      final token = SharedPreferenceService.getString('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response;
      response = await dio.put(ApiService.profileUpdate, data: data);
      print(response.data.toString());
      return Right(response);
    } on DioException catch (e) {
      print(e);
      // final er = e as Map<String, dynamic>;
      // Left(ErrorService(msg: er['message'], code: 0));
      print(e);
      return Left(ErrorService(msg: e.message ?? '', code: 0));
    } catch (e) {
      print(e);
      return Left(ErrorService(msg: '', code: 0));
    }
  }
}
