import 'package:salonapp/screens/profile/cubit/profile_cubit.dart';

class CubitService {
  static final CubitService _instance = CubitService._internal();

  factory CubitService() {
    return _instance;
  }

  CubitService._internal();

  static final profileCubit = ProfileCubit();

  
}
