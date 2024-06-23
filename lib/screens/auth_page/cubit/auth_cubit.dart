// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salonapp/screens/auth_page/data/auth_repository_impl.dart';
import 'package:salonapp/screens/profile/cubit/profile_cubit.dart';
import 'package:salonapp/services/shared_preference_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authRepositoryImpl = AuthRepositoryImpl();
  Future<bool> login(String phoneNumber) async {
    final result = await authRepositoryImpl.login(phoneNumber);

    return result.fold((error) {
      return false;
    }, (success) {
      if (success != null) {
        SharedPreferenceService.setString('phoneNumber', phoneNumber);
        SharedPreferenceService.setString('otp', success.data['data']['otp']);
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    final savedOtp = SharedPreferenceService.getString('otp');
    final result = await authRepositoryImpl.verify(phoneNumber, savedOtp);

    return result.fold((error) {
      return false;
    }, (success) {
      if (success != null) {
        SharedPreferenceService.setString(
            'token', success.data['data']['token']);
        SharedPreferenceService.setBool('isLoggedIn', true);

        return true;
      } else {
        return false;
      }
    });
  }
}
