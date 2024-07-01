import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salonapp/screens/home/data/home_service_repository_impl.dart';
import 'package:salonapp/screens/home/domain/model/service_type_model.dart';

part 'home_service_state.dart';

enum ServiceType { trending, recomended, popular }

class HomeServiceCubit extends Cubit<HomeServiceState> {
  HomeServiceCubit() : super(HomeServiceInitial());

  final _homeServiceRepositoryImpl = HomeServiceRepositoryImpl();

  getServiceByType() async {
    final result = await _homeServiceRepositoryImpl.getSericeByType();

    result.fold((error) => null, (successData) {
      try {
        if (successData != null && successData.data['data'] != null) {
          final serviceTypeData =
              serviceTypesModelFromJson(successData.data['data']);
          emit(HomeServiceDataFetched(
              trending: serviceTypeData
                  .where((element) => element.sellingTag == SellingTag.TRENDING)
                  .toList(),
              recommended: serviceTypeData
                  .where((element) => element.sellingTag == SellingTag.MUST_TRY)
                  .toList(),
              popular: serviceTypeData
                  .where(
                      (element) => element.sellingTag == SellingTag.BEST_SELLER)
                  .toList()));
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
