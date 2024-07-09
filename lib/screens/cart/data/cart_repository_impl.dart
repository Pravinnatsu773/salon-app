import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:salonapp/screens/cart/domain/repository/cart_repository.dart';
import 'package:salonapp/services/api_service.dart';
import 'package:salonapp/services/error_service.dart';
import 'package:salonapp/services/shared_preference_service.dart';

class CartRepositoryImpl extends CartRepository {
  final dio = Dio();

  @override
  Future<Either<ErrorService, Response?>> createCart(
      List<Map<String, dynamic>> cartData) async {
    try {
      final token = SharedPreferenceService.getString('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response;

      response = await dio.post(ApiService.cart, data: cartData);
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
