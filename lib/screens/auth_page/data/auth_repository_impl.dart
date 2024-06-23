import 'package:dio/dio.dart';
import 'package:salonapp/screens/auth_page/domain/repository.dart';

import 'package:either_dart/either.dart';
import 'package:salonapp/services/api_service.dart';
import 'package:salonapp/services/error_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  final dio = Dio();

  @override
  Future<Either<ErrorService, Response?>> login(String phoneNumber) async {
    try {
      Response response;
      response = await dio.post(ApiService.loginViaPhone,
          data: {"phoneNumber": int.parse(phoneNumber)});
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
  Future<Either<ErrorService, Response?>> verify(
      String phoneNumber, String otp) async {
    try {
      Response response;
      response = await dio.post(ApiService.varifyOtp,
          data: {"phoneNumber": int.parse(phoneNumber), "otp": int.parse(otp)});
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
