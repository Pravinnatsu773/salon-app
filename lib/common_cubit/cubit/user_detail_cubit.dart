import 'package:bloc/bloc.dart';
import 'package:salonapp/services/user_detail.dart';

class UserDetailCubit extends Cubit<UserDetail> {
  UserDetailCubit() : super(UserDetail());

  updateValue(UserDetail userDetail) {
    emit(userDetail);
  }
}
