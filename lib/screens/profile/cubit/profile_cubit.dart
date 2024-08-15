import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salonapp/main.dart';
import 'package:salonapp/screens/profile/data/profile_repository_impl.dart';
import 'package:salonapp/screens/profile/domain/model/user_model.dart';
import 'package:salonapp/services/shared_preference_service.dart';
import 'package:salonapp/services/user_detail.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final _profileRepositoryImpl = ProfileRepositoryImpl();

  String firstName = '';
  String lastName = '';
  String dob = '';
  String gender = '';

  Future<String> getProfile() async {
    final result = await _profileRepositoryImpl.getProfile();

    return result.fold((error) {
      return 'shell';
    }, (success) {
      if (success != null) {
        if (success.data['data'] != null &&
            success.data['data']['firstName'] == null) {
          return "register-profile";
        }

        final user = UserModel.fromJson(success.data['data']);

        UserDetail().firstName = user.firstName;

        UserDetail().lastName = user.lastName;

        UserDetail().dob = user.dob;

        UserDetail().gender = user.gender;
        firstName = user.firstName;
        lastName = user.lastName;
        dob = user.dob;
        gender = user.gender;
        updateValueGlobally(UserDetail());

        SharedPreferenceService.setBool('isLoggedIn', true);
        emit(ProfileInLoadedState(user: user));
        return "shell";
      } else {
        return 'shell';
      }
    });
  }

  Future<bool> updateProfile(
      String firstName, String lastName, String dob, String gender) async {
    Map<String, dynamic> data = {"role": "user"};

    if (firstName.isNotEmpty) {
      data['firstName'] = firstName;
    }
    if (lastName.isNotEmpty) {
      data['lastName'] = lastName;
    }
    if (dob.isNotEmpty) {
      data['DOB'] = dob;
    }
    if (gender.isNotEmpty) {
      data['gender'] = gender;
    }

    final result = await _profileRepositoryImpl.updateProfile(data);

    return result.fold((error) {
      return false;
    }, (success) {
      if (success != null) {
        if (success.data != null && success.data['data']['firstName'] != null) {
          SharedPreferenceService.setString(
              "userProfile", success.data['data'].toString());
          final user = UserModel.fromJson(success.data['data']);

          UserDetail().firstName = user.firstName;

          UserDetail().lastName = user.lastName;

          UserDetail().dob = user.dob;

          UserDetail().gender = user.gender;
          firstName = user.firstName;
          lastName = user.lastName;
          dob = user.dob;
          gender = user.gender;
          updateValueGlobally(UserDetail());
          emit(ProfileInLoadedState(user: user));
          return true;
        }
        return false;
      } else {
        return false;
      }
    });
  }
}
